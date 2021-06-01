module PostHelper
  def display_errors(post)
    return unless post.errors.full_messages.any?

    content_tag :p, "Post could not be saved. #{post.errors.full_messages.join('. ')}", class: 'errors'
  end

  def timeline_friend_post(friends, my_posts)
    array = []
    friends.each do |item|
      item.each { |post| array << post }
    end
    my_posts.each { |post| array << post }
    array.sort.reverse
  end
end
