var dict = {
    "Welcome": {
        kn: "ಸ್ವಾಗತ,",
        hi: "स्वागत हे"
    },
    // Language Labels
    "English": {
        kn: "ಇಂಗ್ಲಿಷ್",
        hi: "अंग्रेज़ी"
    },
    "Hindi": {
        kn: "ಹಿಂದಿ",
        hi: "हिंदी"
    },
    "Kannada": {
        kn: "ಕನ್ನಡ",
        hi: "कन्नड़"
    },
    "Malayalam": {
        kn: "ಮಲಯಾಳಂ",
        hi: "मलयालम"
    },
    "Bengali": {
        kn: "ಬೆಂಗಾಲಿ",
        hi: "बंगाली"
    },
    // Sidebar Labels
    "I Need": {
        hi: "मुझे जरूरत है",
        kn: "ನನಗೆ ಬೇಕು"
    },
    "I Offer": {
        kn: "ನಾನು ಕೊಡುತಿರುವುದು",
        hi: "में पेश करता हु"
    },
    "My Needs": {
        kn: "ನನ್ನ ಅಗತ್ಯಗಳು",
        hi: "मेरी जरूरते"
    },
    "My Offers": {
        kn: "ನನ್ನ ಕೊಡುಗೆಗಳು",
        hi: "मेरे प्रस्ताव"
    },
    "Settings": {
        kn: "ಸೆಟ್ಟಿಂಗ್ಗಳು",
        hi: "सेटिंग्स"
    },
    "Help": {
        kn: "ಸಹಾಯ",
        hi: "मदद"
    },
    "Logout": {
        kn: "ಲಾಗ್ ಔಟ್",
        hi: "लोग आउट"
    },
    // Request Help Page Labels
    "Post your need": {
        kn: "ನಿಮ್ಮ ಅಗತ್ಯವನ್ನು ಪೋಸ್ಟ್ ಮಾಡಿ",
        hi: "अपनी जरूरत पोस्ट करें"
    },
    "Category": {
        kn: "ವರ್ಗ",
        hi: "वर्ग"
    },
    "Sub-Category": {
        kn: "ಉಪ ವರ್ಗ",
        hi: "उप-श्रेणी"
    },
    "Quantity": {
        kn: "ಪ್ರಮಾಣ",
        hi: "मात्रा"
    },
    "Unit": {
        kn: "ಘಟಕ",
        hi: "इकाई"
    },
    "Expected Date": {
        kn: "ನಿರೀಕ್ಷಿತ ದಿನಾಂಕ",
        hi: "अपेक्षित तारीख"
    },
    "Address": {
        kn: "ವಿಳಾಸ",
        hi: "पता"
    },
    "Submit Request": {
        kn: "ವಿನಂತಿ ಮಾಡಿ",
        hi: "अनुरोध करें"
    },
    "Delivery Mode": {
        kn: "ಹಂಚಿಕೆ ರೀತಿ",
        hi: "वितरण का माध्यम"
    },
    "Submit Offer": {
        kn: "ಆಫರ್ ಸಲ್ಲಿಸಿ",
        hi: "प्रस्ताव भेजें"
    },
    "Request Info": {
        kn: "ವಿನಂತಿ ಮಾಹಿತಿ",
        hi: "अनुरोध जानकारी"
    },
    "Posted Date": {
        kn: "ಪೋಸ್ಟ್ ಮಾಡಿದ ದಿನಾಂಕ",
        hi: "पोस्ट की तारीख"
    },
    "Status": {
        kn: "ಸ್ಥಿತಿ",
        hi: "स्थिति"
    },
    "Actions": {
        kn: "ಕ್ರಿಯೆಗಳು",
        hi: "क्रिया"
    },
    "-- No Data --": {
        kn: "ಮಾಹಿತಿ ಇಲ್ಲ",
        hi: "कोई आकड़ा उपलब्ध नहीं है"
    },
    "Offer Info": {
        kn: "ಆಫರ್ ಮಾಹಿತಿ",
        hi: "प्रस्ताव जानकारी"
    },
    "Offered By": {
        kn: "ನೀಡುವ ಮೂಲಕ",
        hi: "के द्वारा दिया गया"
    },
    "Delivery Address": {
        kn: "ತಲುಪಿಸುವ ವಿಳಾಸ",
        hi: "डिलिवरी का पता"
    },
    "Requested Quantity": {
        kn: "ವಿನಂತಿಸಿದ ಪ್ರಮಾಣ",
        hi: "अनुरोधित मात्रा"
    },
    "Requested By": {
        kn: "ಕೇಳಿದವರು",
        hi: " वाला"
    },
    "Expected Date": {
        kn: "ನಿರೀಕ್ಷಿತ ದಿನಾಂಕ",
        hi: "अपेक्षित तारीख"
    },
    "Post your offer": {
        kn: "ನಿಮ್ಮ ಕೊಡುಗೆ ನೀಡಿ",
        hi: "अपना प्रस्ताव पोस्ट करें"
    },
    //"Actions": {
    //    kn: "ಕ್ರಿಯೆಗಳು",
    //    hi: "क्रिया"
    //},
    //"Actions": {
    //    kn: "ಕ್ರಿಯೆಗಳು",
    //    hi: "क्रिया"
    //},
}

function getLangId(langCode) {
    switch (langCode) {
        case 'en': return 1;
        case 'ml': return 2;
        case 'hi': return 3;
        case 'kn': return 4;
        case 'bn': return 5;
        default: return 1;
    }
}