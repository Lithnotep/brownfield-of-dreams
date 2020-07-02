class GithubService
  def conn(user)
    Faraday.new(url: "https://api.github.com") do |faraday|
    faraday.headers['Authorization'] = "token #{user.token}"
    end
  end

  def repo_json(user)
    response = conn(user).get("user/repos")
    JSON.parse(response.body, symbolized_names: true)[0..4]
  end

  def follower_json

  end
end