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
  module Plugins

    class StdoutOutput < Outputs::BasicOutput
      Plugin.register_output(:stdout, self)

      def configure(conf)
        super
      end

      def open(tag)
        return Writers::SimpleWriter.new(self, tag)
      end

      def append(tag, time, record)
        STDOUT.write "#{tag}\t#{time}\t#{record.to_json}\n"
      end

      def write(tag, chunk)
        chunk.each {|time,record|
          append(tag, time, record)
        }
      end
    end

  end
end
