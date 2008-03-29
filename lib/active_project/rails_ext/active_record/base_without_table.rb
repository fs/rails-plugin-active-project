module ActiveProject #:nodoc:
    module RailsExt #:nodoc:
        module ActiveRecord #:nodoc:
            
            module BaseWithoutTable
                def self.included(klass)
                    klass.send(:include, ClassMethods)
                end

                module ClassMethods
                    class BaseWithoutTable < ::ActiveRecord::Base
                        self.abstract_class = true

                        def create_or_update
                            errors.empty?
                        end

                        class << self
                            def columns
                                @columns ||= base_class == self ? [] : base_class.columns
                            end

                            def column(name, sql_type = nil, default = nil, null = true)
                                columns.delete_if { |c| c.name == name.to_s }
                                columns << ::ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
                                reset_column_information
                            end

                            # Do not reset @columns
                            def reset_column_information
                                generated_methods.each { |name| undef_method(name) }
                                @column_names = @columns_hash = @content_columns = @dynamic_methods_hash = @read_methods = nil
                            end
                        end
                    end
                end
            end
        end
    end
end

module ::ActiveRecord
    include ActiveProject::RailsExt::ActiveRecord::BaseWithoutTable
end