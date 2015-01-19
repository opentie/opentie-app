class SampleRequest < Request  
  subject "sample request"
  application_period (Time.local 2015, 1, 1, 10)..(Time.local 2015, 5, 1, 10)
  optional false
  in_charge_of :sample
end
