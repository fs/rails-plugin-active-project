module ActiveProject #:nodoc:
    module RubyExt #:nodoc:
        module Class # :nodoc:

            module PublicizeMethods
                def self.included(klass) # :nodoc:
                    klass.send(:include, InstanceMethods)
                end

                module InstanceMethods # :nodoc:
                    def publicize_methods
                        saved_private_instance_methods = self.private_instance_methods
                        saved_protected_instance_methods = self.protected_instance_methods

                        self.class_eval { public *saved_private_instance_methods }
                        self.class_eval { public *saved_protected_instance_methods }

                        yield

                        self.class_eval { private *saved_private_instance_methods }
                        self.class_eval { private *saved_protected_instance_methods }
                    end
                end
            end

        end
    end
end

class Class
    include ActiveProject::RubyExt::Class::PublicizeMethods
end
