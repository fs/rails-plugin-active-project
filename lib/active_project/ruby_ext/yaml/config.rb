module ActiveProject #:nodoc:
    module RubyExt #:nodoc:
        module YAML # :nodoc:           
            
            module Config
                def self.included(klass) # :nodoc:
                    klass.extend(ClassMethods)
                end
                
                module ClassMethods # :nodoc:   
                    def load_config(path)
                        ::YAML.load(
                            ERB.new(
                                File.read(path)
                            ).result(binding)
                        )
                    end
                end
            end
            
        end
    end
end

module YAML # :nodoc:
    include ActiveProject::RubyExt::YAML::Config
end