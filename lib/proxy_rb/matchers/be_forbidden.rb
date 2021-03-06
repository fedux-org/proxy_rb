# frozen_string_literal: true
RSpec::Matchers.define :be_forbidden do
  match do |actual|
    next true if proxy_rb.config.strict == false && (actual.status_code.nil? || actual.status_code.zero?)
    sleep 0.5 # handle network latency

    values_match?(403, actual.status_code)
  end

  failure_message do |actual|
    msg = []

    msg << %(expected that response of "#{resource}" has status code 403, but has #{actual.status_code}.)

    msg << if proxy.nil? || proxy.empty?
             %(No proxy was used.)
           else
             %(It was fetched via proxy "#{proxy}".)
           end

    msg.join ' '
  end

  failure_message_when_negated do
    msg = []

    msg << %(expected that response of "#{resource}" does not have status code 403.)

    msg << if proxy.nil? || proxy.empty?
             %(No proxy was used.)
           else
             %(It was fetched via proxy "#{proxy}".)
           end

    msg.join ' '
  end
end
