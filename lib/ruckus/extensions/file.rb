class File
    module FileExtensions
        module ClassMethods
            def mkfifo(name, mode="666", open_mode="r")
                # XXX not used
                if File.exists? name and File.pipe? name # Leftover from before
                    File.delete name
                end

                # apalling, but ruby/dl has x-p problems
                if ! File.exists? name
                    `mkfifo -m #{ mode } #{ name }`
                end

                return File.open(name, open_mode)
            end
        end

        def self.included(klass)
            klass.extend(ClassMethods)
        end
    end
    include FileExtensions
end
