class GetResponse
  include ActiveModel::Model
  require 'net/http'

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :tag, presence: true

  attr_accessor :email, :tag

  API_URI = "https://api.getresponse.com/v3/"

  def initialize
    @api_key = "api-key #{ENV['GET_RESPONSE_API_KEY']}"
  end

  def add_contact_tag
    raise "Invalid GetResponse data" unless valid?

    query = "contacts/#{get_contact_id_by_email}/tags"
    params = {tags: {tagId: get_tag_id_by_name}}
    send_post(query, params)
  end

  private

  def get_tag_id_by_name
    r = send_get("tags?query[name]=#{self.tag}")
    r.first["tagId"]
  end

  def get_contact_id_by_email
    r = send_get("contacts?query[email]=#{self.email}")
    r.first["contactId"]
  end

  def send_post(query, data = {})
    build_uri(query)
    request = Net::HTTP::Post.new(@uri)
    request.content_type = 'application/json'
    request['X-Auth-Token'] = @api_key
    request.body = data.to_json

    send_query(request)
  end

  def send_get(query)
    build_uri(query)
    request = Net::HTTP::Get.new(@uri)
    request['X-Auth-Token'] = @api_key

    send_query(request)
  end

  def send_query(request)
    http = Net::HTTP.new(@uri.host, @uri.port)
    http.use_ssl = true
    r = http.request(request)

    raise "Failed GetResponse #{request} query" if r.code != '200'
    JSON.parse r.body
  end

  def build_uri(query)
    @uri = URI.parse("#{API_URI}#{query}")
  end
end




