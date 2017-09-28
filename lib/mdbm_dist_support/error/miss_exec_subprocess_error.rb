module MdbmDistSupport
  module Error
		class MissExecSubprocessError < StandardError
			MESSAGE = 'missing exec subprocess'.freeze
			def message(mes = MESSAGE)
				mes
			end
		end
  end
end
