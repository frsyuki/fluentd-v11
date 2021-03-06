#
# Fluentd
#
# Copyright (C) 2011-2012 FURUHASHI Sadayuki
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#
module Fluentd
  module ProcessManager

    require 'tmpdir'
    require 'socket'
    require 'drb'
    require 'drb/unix'
    require 'fileutils'

    class InterProcessExchange
      def initialize(processor_id)
        tmpdir = Dir.tmpdir
        supervisor_pid = Process.pid
        @path = File.join(tmpdir, "fluentd", "processor-#{supervisor_pid}:#{processor_id}")
        @drb_uri = "drbunix:#{@path}"
      end

      def close
        File.unlink(@path) rescue nil
      end

      class DRbFrontObject
        def ref_id(self_id)
          ObjectSpace._id2ref(self_id)
        end
      end

      def start
        FileUtils.mkdir_p File.dirname(@path)
        File.unlink(@path) rescue nil
        @server = DRb::DRbServer.new(@drb_uri, DRbFrontObject.new)
      end

      def join
        @server.thread.join
      end

      def stop_service
        @server.stop_service if @server
      end

      def open_remote_self(local_self, tag)
        remote = DRb::DRbObject.new_with_uri(@drb_uri)
        remote.ref_id(local_self.__id__).open(tag)
      end
    end
  end
end
