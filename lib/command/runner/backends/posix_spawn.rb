module Command
  class Runner
    module Backends

      # Spawns a process using POSIX::Spawn.  This is the preferred
      # method, as POSIX::Spawn is much faster than Process.spawn.
      class PosixSpawn < Spawn

        # Determines whether or not the PosixSpawn class is available as
        # a backend.  Does this by checking to see if posix-spawn has been
        # installed on the local computer; if it hasn't, it returns
        # false.
        #
        # @see Fake.available?
        # @return [Boolean]
        def self.available?
          @_available ||= begin
            require 'posix/spawn'
            true
          rescue LoadError => e
            false
          end
        end

        # Spawns a process with the given line, environment, and options.
        #
        # @see Spawn#spawn
        # @return [Numeric]
        def spawn(env, command, arguments, options)
          POSIX::Spawn.spawn(env, command, *[arguments, options].flatten)
        end

      end
    end
  end
end
