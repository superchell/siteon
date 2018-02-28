class B24
  include ActiveModel::Model
  require 'net/http'

  attr_accessor :api_url, :api_method, :query_params, :query_result

  def initialize
    @api_url = 'https://siteon.bitrix24.ua/rest/8/agsrquzeehpjm6t6/'
  end

  def add_crm_lead(values)
    self.api_method = 'crm.lead.add'
    fields = {
      :TITLE => values[:name],
      :NAME => values[:name],
      :STATUS_ID => "NEW",
      :OPENED => "Y",
      :SOURCE_ID => "WEB",
      :ASSIGNED_BY_ID => 8,
      :CURRENCY_ID => "USD",
      :PHONE =>{ 0 => {:VALUE => values[:phone], :VALUE_TYPE => "WORK"} },
      :EMAIL =>{ 0 => {:VALUE => values[:email], :VALUE_TYPE => "WORK"} }
    }.to_query('fields')
    params = { :REGISTER_SONET_EVENT => "Y" }.to_query('params')
    self.query_params = "#{fields}&#{params}"
    self.run_query

    self.query_result['result']
  end



  # private

  def run_query
    uri = URI(@api_url + self.api_method)
    q = Net::HTTP.post(uri, self.query_params)
    response = JSON.parse(q.body)

    self.query_result = response
    Rails.logger.debug response['error_description'] unless response['error_description'].nil?
  end

end
