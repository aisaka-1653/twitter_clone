// javascriptは未学習のためコピペ
(function () {
  'use strict'

  window.addEventListener('turbo:load', () => {
    if (!location.pathname.includes('/tweets/')) {
      document.querySelectorAll('.tweet').forEach(tweet => {
        tweet.addEventListener('click', function(event) {
          const ignoredClasses = ['.user-link', '.comment-link', '.rt-link', '.like-link', '.bookmark-link'];
          const isIgnoredClick = ignoredClasses.some(className => event.target.closest(className));

          if (!isIgnoredClick) {
            const tweetId = this.getAttribute('data-tweet-id');
            window.location.href = `/tweets/${tweetId}`;
          }
        });
      });
    }
  });
})()