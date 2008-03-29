module ActiveProject #:nodoc:
    module RubyExt #:nodoc:
        module Dir # :nodoc:

            module RequireEach
                def self.included(klass) # :nodoc:
                    klass.extend(ClassMethods)
                end

                module ClassMethods # :nodoc:
                    def require_each(dir)
                        ::Dir[File.dirname(File.expand_path(caller.first)) + "/#{dir}/*.rb"].each { |file| require(file) }
                    end
                end
            end

        end
    end
end

class Dir
    include ActiveProject::RubyExt::Dir::RequireEach
end