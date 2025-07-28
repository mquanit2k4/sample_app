import { I18n } from 'i18n-js';
import translations from './translation';

const i18n = new I18n(translations);
i18n.defaultLocale = document.documentElement.dataset.defaultLocale || 'en';
i18n.locale = document.documentElement.dataset.locale || 'en';
window.I18n = i18n;

document.addEventListener('turbo:load', function () {
  const image_upload = document.querySelector('#micropost_image');
  if (!image_upload) return;

  image_upload.addEventListener('change', function (event) {
    if (!image_upload.files.length) return;

    const size_in_megabytes = image_upload.files[0].size / 1024 / 1024;
    const MAX_ALLOWED_SIZE_MB = parseFloat(image_upload.dataset.maxFileSizeMb);

    if (size_in_megabytes > MAX_ALLOWED_SIZE_MB) {
      alert(i18n.t('microposts.image_size_alert', { max_size: MAX_ALLOWED_SIZE_MB }));
      image_upload.value = '';
    }
  });
});
