require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'json'
require 'csv'

"""
Scrapes JSON output from WhoSigned.org and returns a basic CSV file. Iterates through the signers in batches of 5,000,
and name portions of the results are embedded in HTML.
"""


output = []
range = Range.new(0,123656)
CSV.open("signers.csv", "wb") do |csv|
  range.step(5000).each do |start|
    url = "http://whosigned.org/AjaxHandler?sEcho=1&iColumns=8&sColumns=FirstName%2CMiddleName%2CLastName%2CSuffix%2CAddress%2CCity%2CState%2CZip&iDisplayStart=#{start}&iDisplayLength=5000&mDataProp_0=0&mDataProp_1=1&mDataProp_2=2&mDataProp_3=3&mDataProp_4=4&mDataProp_5=5&mDataProp_6=6&mDataProp_7=7&sSearch=&bRegex=false&sSearch_0=&bRegex_0=false&bSearchable_0=true&sSearch_1=&bRegex_1=false&bSearchable_1=true&sSearch_2=&bRegex_2=false&bSearchable_2=true&sSearch_3=&bRegex_3=false&bSearchable_3=false&sSearch_4=&bRegex_4=false&bSearchable_4=true&sSearch_5=&bRegex_5=false&bSearchable_5=true&sSearch_6=&bRegex_6=false&bSearchable_6=false&sSearch_7=&bRegex_7=false&bSearchable_7=true&iSortingCols=3&iSortCol_0=2&sSortDir_0=asc&iSortCol_1=0&sSortDir_1=asc&iSortCol_2=1&sSortDir_2=asc&bSortable_0=true&bSortable_1=true&bSortable_2=true&bSortable_3=false&bSortable_4=true&bSortable_5=true&bSortable_6=false&bSortable_7=true"
    response = JSON.parse(open(url).read)
    results = response['aaData']
    results.each do |result|
      csv << result.reject{|r| r == ''}
    end
  end
end
