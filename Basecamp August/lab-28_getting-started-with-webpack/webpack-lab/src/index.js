import './style.css';
import measure from './assets/house-design.png'

const imgBrand = document.getElementById('imgBrand');
imgBrand.src = measure

// Use the values from the HTML page
const formControl = document.querySelector('form');
const inputControl = document.querySelector('input');
const outputControl = document.querySelector('#conversion');

// Set the output to blank when the screen starts
outputControl.textContent = '';

// Handle form processing
formControl.addEventListener('submit', (event) => {
  event.preventDefault();

  if (parseInt(inputControl.value)) {
    const calcResult = (inputControl.value * 2.4711).toFixed(2);
    outputControl.textContent = inputControl.value.toString() + " Hectares is " + calcResult.toString() + " Acres";
  }
})
