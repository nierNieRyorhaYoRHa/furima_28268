if (document.URL.match( "/new" ) || document.URL.match( "/items" )) {
  document.addEventListener('DOMContentLoaded', function(){
    const imageList = document.getElementById('image-list');

    // 選択した画像を表示する関数
    const createImageHTML = (blob) => {
      // 画像を表示するためのdiv要素を生成
      const imageElement = document.createElement('div');
      imageElement.setAttribute('id', "image-element");
      let imageElementNum = document.querySelectorAll('#image-element').length;

      // 表示する画像を生成
      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      blobImage.width = 600;

      // ファイル選択ボタンを生成
      const inputHTML = document.createElement('input');
      inputHTML.setAttribute('id', `item_image_${imageElementNum}`);
      inputHTML.setAttribute('name', 'item_tag[images][]');
      inputHTML.setAttribute('type', 'file');

      // 生成したHTMLの要素をブラウザに表示させる
      imageElement.appendChild(blobImage);
      imageElement.appendChild(inputHTML);
      imageList.appendChild(imageElement);

      inputHTML.addEventListener('change', (e) => {
        file = e.target.files[0];
        blob = window.URL.createObjectURL(file);

        createImageHTML(blob);
      })
    };

    document.getElementById('item-image').addEventListener('change', function(e){

      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);

      createImageHTML(blob);
    });
  });
}
