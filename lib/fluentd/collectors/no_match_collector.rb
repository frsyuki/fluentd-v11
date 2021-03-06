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
  module Collectors

    class NoMatchCollector
      include Collector

      def open(tag, &block)
        return ensure_close(open(tag), &proc) if block_given?
        # TODO
        #$log.on_trace { $log.trace "no patterns matched", :tag=>tag }
        return NoMatchWriter.new
      end

      class NoMatchWriter
        include Writer

        def append(time, record)
          # TODO
        end

        def write(chunk)
          # TODO
        end

        def close
          # TODO
        end
      end
    end

  end
end
