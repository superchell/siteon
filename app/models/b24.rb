class B24
  include ActiveModel::Model
  require 'net/http'

  attr_accessor :api_url, :api_method, :query_params, :query_result

  def initialize
    @api_url = 'https://siteon.bitrix24.ua/rest/1/90kkwgz4ezkycxx9/'
  end

  def add_crm_lead(values)
    self.api_method = 'crm.lead.add'
    fields = {
      :TITLE => values[:name],
      :NAME => values[:name],
      :STATUS_ID => "NEW",
      :OPENED => "Y",
      :ASSIGNED_BY_ID => 1,
      :CURRENCY_ID => "USD",
      :PHONE =>{ 0 => {:VALUE => values[:phone], :VALUE_TYPE => "WORK"} }
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
  end

end
