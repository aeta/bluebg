var loadFile = function(event) {
  var output = document.getElementById('image-preview-1');
  output.src = URL.createObjectURL(event.target.files[0]);
};
