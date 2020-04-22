class FeedsController < ApplicationController
  def show
    @repo = Repo.find(params[:id])

    @timestamp = DateTime.now
    @since = (@timestamp - 1).iso8601
    response = Net::HTTP.get_response(URI(data_url(@repo.name, @since)))
    if response.is_a?(Net::HTTPSuccess)
      @data = JSON.parse(response.body)
      if @data.size > 0
        respond_to do |format|
          format.xml do
            send_data render_to_string(template: "feeds/atom.xml.erb"),
                      type: "application/atom+xml; charset=UTF-8"
          end
        end
      end
    end
  end

  private

    def data_url(name, since)
      "https://api.github.com/repos/#{name}/issues?since=#{since}&sort=updated&state=all"
    end

end
