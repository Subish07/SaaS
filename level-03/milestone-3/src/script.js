// This is a closure function https://medium.com/javascript-scene/master-the-javascript-interview-what-is-a-closure-b2f0d2152b36
(function() {
  var initialize = function() {
    /*
      1. Add all your event bindings here. Please avoid binding events inline and add your event listeners here.

      onSubmit callback
      disableDuplicateSecondaryDepartment callback,...
    */
   let x=document.getElementsByClassName("department");
   x[1].addEventListener("focus",disableDuplicateSecondaryDepartment);
   let y=document.getElementsByClassName("button");
   y[0].addEventListener("click",onSubmit);
  };

  var disableDuplicateSecondaryDepartment = function(event) {
    // 2. in department2, Should disable the option selected in department1
  let x=document.getElementsByClassName("department");
  let number=0;
  for (var i = 0; i < x[1].options.length; i++) {
    var opt = x[1].options[i];
    if (opt.value===x[0].value)
      opt.disabled=true;
  }
}


  var constructData = function() {
    var data = {};
    // 3. Construct data from the form here. Please ensure that the keys are the names of input elements
    data.name=document.forms[0]["name"].value;
    data.phone=document.forms[0]["phno"].value;
    data.email=document.forms[0]["emailaddress"].value;
    data.dept1=document.forms[0]["department1"].value;
    data.dept2=document.forms[0]["department2"].value;
    return data;
  }

  var validateResults = function(data) {
    var isValid = true;
    var reg=/^[a-zA-Z0-9._-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])\.edu$/;
    var x=data.email;
    console.log(data);
    if(data.name.length>100)
    {
      isValid=false;
      console.log("name");
    }
    else if(data.phone.length>10)
    {
      isValid=false;console.log("7");
    }
    else if (reg.test(data.email) == false) 
    {
        isValid=false;console.log("hell");
    }
    return isValid;
    // 4. Check if the data passes all the validations here
   
  };

  var onSubmit = function(event) {
    // 5. Figure out how to avoid the redirection on form submit
    event.preventDefault();
    var data = constructData();

    if (validateResults(data)) {
      printResults(data);
      console.log("success");
    } else {
      console.log("error");
      var resultsDiv = document.getElementById("results");
      resultsDiv.innerHTML = '';
      resultsDiv.classList.add("hide");
    }
  };

  var printResults = function(data) {
    var constructElement = function([key, value]) {
      return `<p class='result-item'>${key}: ${value}</p>`;
    };

    var resultHtml = (Object.entries(data) || []).reduce(function(innerHtml, keyValuePair) {
      debugger
      return innerHtml + constructElement(keyValuePair);
    }, '');
    var resultsDiv = document.getElementById("results");
    resultsDiv.innerHTML = resultHtml;
    resultsDiv.classList.remove("hide");
  };

  /*
    Initialize the javascript functions only after the html DOM content has loaded.
    This is to ensure that the elements are present in the DOM before binding any event listeners to them.
  */
  document.addEventListener('DOMContentLoaded', initialize);
})();
