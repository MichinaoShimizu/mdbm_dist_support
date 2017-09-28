module MdbmDistSupport
  module Error
		class InvalidSettingsError < StandardError
			MESSAGE = 'invalid settings'.freeze
			def message(mes = MESSAGE)
				mes
			end
		end
  end
end
