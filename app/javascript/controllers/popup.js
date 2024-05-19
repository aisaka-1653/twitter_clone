// javascriptは未学習のためコピペ
(function () {
  'use strict'

  window.addEventListener('turbo:load', () => {
    const modals = document.querySelectorAll('.more-option');
    modals.forEach(modal => {
      const buttonOpen = modal.querySelector('#modalOpen');
      const easyModal = modal.querySelector('#easyModal');
      const tweet = modal.closest('.tweet');

      buttonOpen.addEventListener('click', function(e) {
        e.stopPropagation();
        easyModal.style.display = 'block';
        tweet.classList.add('modal-open');

        // モーダルを開いたときの背景の変更
        document.body.style.pointerEvents = 'none';
        document.body.style.cursor = 'default';

        // モーダル上のボタンのスタイルを変更
        const modalButtons = easyModal.querySelectorAll('button');
        modalButtons.forEach(button => {
          button.style.pointerEvents = 'auto';
          button.style.cursor = 'pointer';
        });
      });

      // モーダルの背景をクリックしたときにモーダルを閉じる
      document.addEventListener('click', function(e) {
        if (!easyModal.contains(e.target) && e.target !== buttonOpen) {
          easyModal.style.display = 'none';
          tweet.classList.remove('modal-open');

          // モーダルを閉じたときの背景の変更
          document.body.style.pointerEvents = 'auto';
          document.body.style.cursor = 'auto';
        }
      });
    });
  });
})()