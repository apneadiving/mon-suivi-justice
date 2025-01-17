# rails r bin/sendinblue/send_test_sms.rb

require 'sib-api-v3-sdk'

SibApiV3Sdk.configure do |config|
  config.api_key['api-key'] = ENV['SIB_API_KEY']
  config.api_key['partner-key'] = ENV['SIB_API_KEY']
end

api_instance = SibApiV3Sdk::TransactionalSMSApi.new

sms = SibApiV3Sdk::SendTransacSms.new(
  sender: 'MSJ',
  recipient: ENV['PHONE_REMY'],
  content: "Bonjour M. Lucas, pour rappel vous avez rendez-vous au SPIP des Hauts-de-Seine le 24 juin à 9h00, au 94 boulevard du Général Leclerc à Nanterre. En cas de problème, contactez le SPIP."
)

# recipient: phone number with country code, ex: '+33607070707'

begin
  result = api_instance.send_transac_sms(sms)
  p result
rescue SibApiV3Sdk::ApiError => e
  puts "Exception when calling TransactionalSMSApi->send_transac_sms: #{e}"
end
