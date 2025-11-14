// --- 1. Define Variables ---
const url = 'https://test-hrm.beyondtechnepal.com/api/attendance/clock';

// IMPORTANT: Replace this placeholder with your actual, valid token.
// Using the token visible in your last screenshot as an example (since the original token was replaced).
const token = '87wvkj9oXnJs3QzXmZd5w4PRbtZscl5qeA/NHeBzNfSoE9vm3d98gqaA'; 

// The request body, including the coordinates.
// Use your actual location if geo-fencing is enforced.
const requestBody = {
    "latitude": 27.7172,
    "longitude": 85.3240
};

// --- 2. Define the Request Configuration ---
const requestOptions = {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}` // Use the actual token
    },
    // The request body must be converted to a JSON string
    body: JSON.stringify(requestBody)
};

// --- 3. Execute the Fetch Request ---
fetch(url, requestOptions)
    .then(response => {
        // Check if the response is okay (status code 200-299)
        if (!response.ok) {
            // Handle HTTP errors (like 401, 404, 500)
            console.error(`HTTP error! Status: ${response.status}`);
            // Attempt to return error details as JSON
            return response.json().then(errorData => {
                throw new Error(JSON.stringify(errorData));
            });
        }
        // Parse the successful JSON response
        return response.json();
    })
    .then(data => {
        // Log the successful Clock In/Out response data
        console.log('Success:', data);
    })
    .catch(error => {
        // Log any errors during the fetch or processing
        console.error('Fetch Error:', error.message);
    });