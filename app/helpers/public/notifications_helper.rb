module Public::NotificationsHelper

  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    your_post = link_to 'あなたの投稿', customers_path(notification), style: "font-weight: bold;"
    @visiter_comment = notification.post_comment_id
    # notification.actionがfollowかfavoriteかcommentか
    case notification.action
      when "follow" then
        tag.a(notification.visiter.full_name, href:customer_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
      when "favorite" then
        tag.a(notification.visiter.full_name, href:customer_path(@visiter), style: "font-weight: bold;")+"が"+tag.a('あなたの投稿', href: post_path(notification.post_id), style: "font-weight: bold;")+"にいいねしました"
      when "comment" then
      	@comment = PostComment.find_by(id: @comment) &.content
      	tag.a(@visiter.full_name, href:customer_path(@visiter), style: "font-weight: bold;")+"が"+tag.a('あなたの投稿', href: post_path(notification.post_id), style: "font-weight: bold;")+"にコメントしました"
    end
  end

  def unchecked_notifications
    @notifications = current_customer.passive_notifications.where(checked: false)
  end
end
