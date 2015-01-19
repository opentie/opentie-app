class SampleRequest < Opentie::Core::Request
  subject "sample request"
  application_period (Time.local 2015, 1, 1, 10)..(Time.local 2015, 5, 1, 10)
  declinable false
  in_charge_of :sample
end
