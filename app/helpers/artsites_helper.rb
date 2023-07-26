module ArtsitesHelper
  def random_unsplash_image_tag(options = {})
    image_url = get_random_unsplash_image_url
    image_tag(image_url, options)
  end

  private
  def get_random_unsplash_image_url
    access_key = Rails.application.secrets.unsplash_client_id

    api_url = "https://api.unsplash.com/photos/random?client_id=#{access_key}"
    # api_url = "https://api.unsplash.com/photos/random/#{width}x#{height}?client_id=#{access_key}"
    response = HTTParty.get(api_url)

    if response.code == 200
      json_response = JSON.parse(response.body)
      json_response['urls'] ['regular' ]
    else
      raise StandardError, 'Failed to fetch image from Unsplash API'
    end
  end
end
