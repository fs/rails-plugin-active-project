module Flatsoft
    module Plugins
        module Acts #:nodoc:
            #   class Post < ActiveRecord::Base
            #       acts_as_permalink
            #   end
            # 
            #   post = Post.new(:caption => 'Mega caption').save
            #   post.url # => "mega-caption"
            #   post.to_param # => "mega-caption"
            # 
            module Permalink

                def self.included(base) # :nodoc:
                    base.extend ClassMethods

	                class << base
        	            attr_accessor :permalink_options
    	            end
                end
            
                module ClassMethods
                    def acts_as_permalink(options = {})
                        options.assert_valid_keys :from, :to, :permalink_url?
                    
                        options[:from] ||= :caption
                        options[:to] ||= :url
                        options[:permalink_url?] ||= true
                    
                        before_save ActsMethods::UrlMaker.new(options[:to], options[:from])                                    
                    
                        if options[:permalink_url?]
                            define_method(:to_param) do
                                send(options[:to])
                            end
                        end

						self.permalink_options = options
                    end                

					def find_by_param(param, *args)
						send("find_by_#{self.permalink_options[:to]}", param, *args) || raise(ActiveRecord::RecordNotFound)
					end

                end
            
                module ActsMethods
                
                    class UrlMaker
                        def initialize(url, from)
                            @url    = url
                            @from   = from
                        end
                    
                        def before_save(record)
                            record[@url] = record[@from] if record[@url].blank?
                            record[@url] = record[@url].respond_to?(:dirify) ? record[@url].dirify : record[@url].to_permalink
                        end
                    end
                
                end
            
            
            end
        end
    end
end