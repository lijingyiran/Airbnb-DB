// connects to queries.go
// html is the presentation, .js is the controller than defines the action of the presentation
// for instance, when you click a button (provided by .html),
// .js defines the action that happens and sends info to the backend
// then the backend will execute the coresponding queries
// part of the gui that we cannot see

window.onload = () => {
  // when get employees button is clicked
  document.getElementById("employees").onclick = async () => {
    const race = document.getElementById("race1").value; // gets the value in the race input box

    // calls the api and passes where clause as race
    // and passes the user's race input
    const res = await fetch('http://localhost:1323/api/employee?where=race&race=' + race);
    const data = await res.json();

    document.getElementById("race1").value = ''; // reset input box(es)

    document.getElementById('sql-results').value = ''; // clears the input box
    document.getElementById('sql-results').innerText = data; // displays the SQL data
  }

  // when get money transfer button is clicked
  document.getElementById("transfer").onclick = async () => {
    document.getElementById('sql-results').innerText = ""; // displays the SQL data
    const money = document.getElementById("money").value; // gets the value in the money input box
    const date = document.getElementById('date').value; // gets the value in the date input box

    // calls the api and passes the user's money and date input
    const res = await fetch('http://localhost:1323/api/money_transfer?amount='+money+'&date='+date);
    const data = await res.json();

    document.getElementById("money").value = ''; // reset input box(es)
    document.getElementById("date").value = ''; // reset input box(es)

    console.log(data);
    for (element in data) {
      console.log(data[element])
      document.getElementById('sql-results').innerText += data[element].TransactionNum + " " + "\n"; // displays SQL data
    }
  }

  // get account number
  document.getElementById("transfer2").onclick = async () => {
    document.getElementById('sql-results').innerText = ""; // displays the SQL data
    const money = document.getElementById("money2").value; // gets the value in the money input box
    const date = document.getElementById('date2').value; // gets the value in the date input box

    // calls the api and passes the user's money and date input
    const res = await fetch('http://localhost:1323/api/money_transfer_join?amount=' + money + '&date=' + date);
    const data = await res.json();

    document.getElementById("money2").value = ''; // reset input box(es)
    document.getElementById("date2").value = ''; // reset input box(es)

    document.getElementById('sql-results').innerText = data; // displays SQL data
  }


  // get host account id
  document.getElementById("guests").onclick = async () => {
    document.getElementById('sql-results').innerText = ""; // displays the SQL data
    const host = document.getElementById("host").value; // gets the value in the money input box
    const res = await fetch('http://localhost:1323/api/guests_talk_to_hosts?host_id=' + host);
    const data = await res.json();

    document.getElementById("host").value = ''; // reset input box(es)

    document.getElementById('sql-results').innerText = data; // displays SQL data
  }

  // get commission
  document.getElementById("staffid").onclick = async () => {
    document.getElementById('sql-results').innerText = ""; // displays the SQL data
    const res = await fetch('http://localhost:1323/api/commission');
    const data = await res.json();

    document.getElementById("host").value = ''; // reset input box(es)

    for (element in data) { //element is each row in the data
      console.log(data[element])
      document.getElementById('sql-results').innerText += data[element]["Staffid"] + " " + data[element]["Commission"] + "\n";
    } //generate result to display on index.html page
  }

  // when get money transfer button is clicked
  document.getElementById("add-employee").onclick = async () => {
    document.getElementById('sql-results').innerText = ""; // displays the SQL data
    // calls the api and passes the user's money and date input
    const res = await fetch('http://localhost:1323/api/employee', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        staffid: document.getElementById('staff-id').value,
        age: document.getElementById('age').value,
        race: document.getElementById('race2').value
      })
    });
    const data = await res.json();

    document.getElementById("staff-id").value = ''; // reset input box(es)
    document.getElementById("age").value = ''; // reset input box(es)
    document.getElementById("race2").value = ''; // reset input box(es)

    console.log(data);
    for (element in data) {
      console.log(data[element])
      document.getElementById('sql-results').innerText += data[element].Staffid + " " + data[element].Age + " " + data[element].Race + "\n"; // displays SQL data
    }
  }

  // when delete staff button is clicked
  document.getElementById("delete-staff").onclick = async (event) => {
    document.getElementById('sql-results').innerText = ""; // displays the SQL data
    const staff_id = document.getElementById("staff-id2").value; // gets the value in the staff input box

    // calls the api and passes the staff id
    const res = await fetch('http://localhost:1323/api/delete_staff?staff_id=' + staff_id, {
      method: 'DELETE'
    });
    const data = await res.json();

    document.getElementById("staff-id2").value = ''; // reset input box(es)

    console.log(data);
    for (element in data) {
      console.log(data[element])
      document.getElementById('sql-results').innerText += data[element].Staffid + " " + data[element].Age + " " + data[element].Race + "\n"; // displays SQL data
    }
  }



  // when delete upcomingbooking button is clicked
  document.getElementById("delete-upcomingbooking").onclick = async (event) => {
    document.getElementById('sql-results').innerText = ""; // displays the SQL data
    const ConfirmationNum = document.getElementById("upcomingbooking").value; // gets the value in the staff input box

    const res = await fetch('http://localhost:1323/api/delete_upcomingbooking?ConfirmationNum=' + ConfirmationNum, {
      method: 'DELETE'
    });
    const data = await res.json();

    document.getElementById("upcomingbooking").value = ''; // reset input box(es)

    console.log(data);
    for (element in data) {
      console.log(data[element])
      document.getElementById('sql-results').innerText += data[element].ConfirmationNum + " " + data[element].CheckinTime + " " + data[element].ListingID + "\n"; // displays SQL data
    }
  }

  // when update ziphood button is clicked
  document.getElementById("update-ziphood").onclick = async (event) => {
    document.getElementById('sql-results').innerText = ""; // displays the SQL data
    const zip1 = document.getElementById("zip1").value; // gets the value in the zip1 input box

    const zip2 = document.getElementById("zip2").value; // gets the value in the zip2 input box

    const houselocation = document.getElementById("houselocation").value; // gets the value in the zip3 input box

    // calls the api and passes the staff id
    const res = await fetch('http://localhost:1323/api/update_ziphood', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        zip1: document.getElementById('zip1').value,
        zip2: document.getElementById('zip2').value,
        houselocation: document.getElementById('houselocation').value
      })
    });
    const data = await res.json();

    document.getElementById("zip1").value = ''; // reset input box(es)
    document.getElementById("zip2").value = ''; // reset input box(es)
    document.getElementById("houselocation").value = ''; // reset input box(es)

    console.log(data);
    for (element in data) {
      console.log(data[element])
      document.getElementById('sql-results').innerText += data[element].Zipcode + " " + data[element].Houselocation + "\n"; // displays SQL data
    }
  }

  // when get-avg-money button is clicked
  document.getElementById("get-avg-money").onclick = async (event) => {
    document.getElementById('sql-results').innerText = ""; // displays the SQL data
    const date = document.getElementById('money-date').value;

    // calls the api and passes the race2 id
    const res = await fetch('http://localhost:1323/api/get_avg_money?date=' + date);
    const data = await res.json();

    document.getElementById('sql-results').innerText = data; // displays SQL data
  }

  // when get-guests-by-sin button is clicked
  document.getElementById("get-guests").onclick = async (event) => {
    document.getElementById('sql-results').innerText = ""; // displays the SQL data
    // calls the api and passes the race2 id
    const res = await fetch('http://localhost:1323/api/get_guests_by_sin');
    const data = await res.json();

    document.getElementById('sql-results').innerText = data; // displays SQL data
  }

  // when get-account-rating button is clicked
  document.getElementById("get-account-rating").onclick = async (event) => {
    const id = document.getElementById('listing-id').value;
    document.getElementById('sql-results').innerText = ""; // displays the SQL data
    // calls the api and passes the race2 id
    const res = await fetch('http://localhost:1323/api/account_with_rating?listingid=' + id);
    const data = await res.json();

    console.log(data);
    for (element in data) {
      console.log(data[element])
      document.getElementById('sql-results').innerText += data[element].ListingID + " " + data[element].HostAccountNum + "\n"; // displays SQL data
    }
  }
}
