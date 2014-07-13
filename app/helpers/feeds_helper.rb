module FeedsHelper
  def feed_error_messages!
    return "" if @feed.errors.empty?

    messages = @feed.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      count: @feed.errors.count,
                      resource: @feed.class.model_name.human.downcase)

    html = <<-HTML
    <div class="sheet">
      <h2 align="center">#{sentence}</h2>
      <h4 align="left">#{messages}</h4>
    </div>
    HTML

    html.html_safe
  end
end
