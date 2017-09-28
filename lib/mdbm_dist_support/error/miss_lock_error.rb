module MdbmDistSupport
  module Error
		class MissLockError < StandardError
			MESSAGE = 'missing get lock'.freeze
			def message(mes = MESSAGE)
				mes
			end
		end
  end
end
