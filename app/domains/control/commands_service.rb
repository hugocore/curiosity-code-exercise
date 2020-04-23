# frozen_string_literal: true

module Control
  class CommandsService
    include AutoInject['navigation_service']
    include AutoInject['operational_service']

    SUPPORTED_COMMANDS = (Navigation::Commands::ALL + Operational::Commands::ALL).freeze

    def call(robot_id:, commands:, raise_errors: true)
      commands.each do |command|
        break invalid_command_error(command, raise_errors) unless valid_command?(command)

        service = parse_command(command)

        public_send(service).call(robot_id: robot_id, commands: [command])
      end
    end

    private

    def invalid_command_error(command, raise_errors)
      error_message = "Command '#{command}' is invalid"

      raise Errors::CommandNotSupported, error_message if raise_errors

      Rails.logger.error error_message
    end

    def valid_command?(command)
      SUPPORTED_COMMANDS.include? command
    end

    def parse_command(command)
      if Navigation::Commands::ALL.include? command
        :navigation_service
      elsif Operational::Commands::ALL.include? command
        :operational_service
      end
    end
  end
end
