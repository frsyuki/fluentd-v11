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

    class CopyFilter < Outputs::BasicOutput
      include StreamSource

      Plugin.register_filter(:copy, self)

      class CopyWriter
        include Writer

        def initialize(writer)
          @writer = writer
        end

        def append(time, record)
          @writer.append(time, record)
          return time, record
        end

        def write(chunk)
          @writer.write(chunk)
          return chunk
        end

        def close
          @writer.close
        end
      end

      def open(tag)
        w = stream_source.open(tag)
        return CopyWriter.new(w)
      end
    end

  end
end

