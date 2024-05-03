// javascriptは未学習のためコピペ
(function () {
  'use strict'

  window.addEventListener('load', () => {
    const avatarUploader = document.querySelector('.avatar-uploader');
    const headerUploader = document.querySelector('.header-uploader');

    avatarUploader.addEventListener('change', (e) => {
      const file = avatarUploader.files[0];
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => {
        const image = reader.result;
        document.querySelector('.avatar-preview').setAttribute('src', image);
      }
    });

    headerUploader.addEventListener('change', (e) => {
      const file = headerUploader.files[0];
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => {
        const image = reader.result;
        document.querySelector('.header-preview').setAttribute('src', image);
      }
    });
  });
})()