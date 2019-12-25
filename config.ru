# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application

unless ENV['RAILS_ENV'] == 'development'
  require 'unicorn/worker_killer'
  CHECK_CYCLE = 16
  use Unicorn::WorkerKiller::Oom, (400*(1024**2)), (500*(1024**2)), CHECK_CYCLE
end