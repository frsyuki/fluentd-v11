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
    here = File.expand_path(File.dirname(__FILE__))

    {
      :SimpleProcessManager => 'process_manager/simple_process_manager',
      :MultiprocessManager => 'process_manager/multiprocess_manager',
      :SingleprocessManager => 'process_manager/singleprocess_manager',
      :ChildProcess => 'process_manager/child_process',
      :InterProcessExchange => 'process_manager/inter_process_exchange',
    }.each_pair {|k,v|
      autoload k, File.join(here, v)
    }

    def self.new(config)
      # TODO config or environment switches implementations
      #SimpleProcessManager.new
      MultiprocessManager.new
      #SingleprocessManager.new
    end

  end
end

