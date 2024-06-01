# frozen_string_literal: true

module NotificationsHelper
  def custom_link(notification, &block)
    case notification.notifiable_type
    when 'Interaction', 'Comment'
      link_to tweet_path(notification.notifiable.tweet), class: 'text-decoration-none text-dark', &block
    when 'Follow'
      link_to user_path(notification.notifiable.follower), class: 'text-decoration-none text-dark', &block
    end
  end

  def custom_icon(notification)
    case notification.notifiable_type
    when 'Interaction'
      interaction_icon(notification.notifiable.type)
    when 'Follow'
      follow_icon
    when 'Comment'
      comment_icon
    end
  end

  def custom_content(notification)
    case notification.notifiable_type
    when 'Interaction'
      safe_join(notification.notifiable.tweet.content.split("\n"), tag.br)
    when 'Comment'
      safe_join(notification.notifiable.content.split("\n"), tag.br)
    end
  end

  def notification_message(notification)
    case notification.notifiable_type
    when 'Interaction'
      case notification.notifiable.type
      when 'Like'
        'さんがあなたのツイートをいいねしました'
      when 'Retweet'
        'さんがあなたのツイートをリツイートしました'
      end
    when 'Follow'
      'さんにフォローされました'
    when 'Comment'
      'さんがあなたのツイートにコメントしました'
    end
  end
end

def interaction_icon(type)
  case type
  when 'Like'
    content_tag(:svg, class: 'bi bi-heart-fill mt-2', xmlns: 'http://www.w3.org/2000/svg', width: '32', height: '32',
                      fill: '#F91880', viewBox: '0 0 16 20') do
      content_tag(:path, nil, fill_rule: 'evenodd',
                              d: 'M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z')
    end
  when 'Retweet'
    content_tag(:svg, class: 'bi bi-shuffle mt-2', xmlns: 'http://www.w3.org/2000/svg', width: '32', height: '32',
                      fill: '#00BA7C', viewBox: '0 0 16 22') do
      content_tag(:path, nil, fill_rule: 'evenodd',
                              d: 'M0 3.5A.5.5 0 0 1 .5 3H1c2.202 0 3.827 1.24 4.874 2.418.49.552.865 1.102 1.126 1.532.26-.43.636-.98 1.126-1.532C9.173 4.24 10.798 3 13 3v1c-1.798 0-3.173 1.01-4.126 2.082A9.624 9.624 0 0 0 7.556 8a9.624 9.624 0 0 0 1.317 1.918C9.828 10.99 11.204 12 13 12v1c-2.202 0-3.827-1.24-4.874-2.418A10.595 10.595 0 0 1 7 9.05c-.26.43-.636.98-1.126 1.532C4.827 11.76 3.202 13 1 13H.5a.5.5 0 0 1 0-1H1c1.798 0 3.173-1.01 4.126-2.082A9.624 9.624 0 0 0 6.444 8a9.624 9.624 0 0 0-1.317-1.918C4.172 5.01 2.796 4 1 4H.5a.5.5 0 0 1-.5-.5z', stroke: '#00BA7C', stroke_width: '0.6') +
        content_tag(:path, nil,
                    d: 'M13 5.466V1.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384l-2.36 1.966a.25.25 0 0 1-.41-.192zm0 9v-3.932a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384l-2.36 1.966a.25.25 0 0 1-.41-.192z')
    end
  end
end

def follow_icon
  content_tag(:svg, class: 'bi bi-person-fill mt-2', xmlns: 'http://www.w3.org/2000/svg', width: '32', height: '32',
                    fill: '#1D9BF0', viewBox: '0 0 16 16') do
    content_tag(:path, nil, d: 'M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3Zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z')
  end
end

def comment_icon
  content_tag(:svg, class: 'bi bi-chat-dots-fill mt-2', xmlns: 'http://www.w3.org/2000/svg', width: '32', height: '32',
                    fill: '#1D9BF0', viewBox: '0 0 16 20') do
    content_tag(:path, nil,
                d: 'M16 8c0 3.866-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.584.296-1.925.864-4.181 1.234-.2.032-.352-.176-.273-.362.354-.836.674-1.95.77-2.966C.744 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7zM5 8a1 1 0 1 0-2 0 1 1 0 0 0 2 0zm4 0a1 1 0 1 0-2 0 1 1 0 0 0 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z')
  end
end
