// javascriptは未学習のためコピペ
(function () {
  'use strict'

  window.addEventListener('turbo:load', () => {
    const imageUploader = document.querySelector('.image-uploader');
    const cardBody = document.querySelector('.card-body');

    imageUploader.addEventListener('change', (e) => {
      const file = imageUploader.files[0];
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => {
        // 既存のプレビュー画像を削除
        const existingImageContainer = cardBody.querySelector('.image-container');
        if (existingImageContainer) {
          existingImageContainer.remove();
        }

        const imageContainer = document.createElement('div');
        imageContainer.className = 'image-container position-relative';

        const image = document.createElement('img');
        image.src = reader.result;
        image.className = 'tweet-image mt-2';
        imageContainer.appendChild(image);

        const removeButton = document.createElement('button');
        removeButton.className = 'btn btn-dark remove-btn';
        removeButton.innerHTML = '&times;';
        removeButton.addEventListener('click', () => {
          imageContainer.remove();
          imageUploader.value = ''; // ファイル選択をリセット
        });
        imageContainer.appendChild(removeButton);

        cardBody.appendChild(imageContainer);
      }
    });
  });
})()