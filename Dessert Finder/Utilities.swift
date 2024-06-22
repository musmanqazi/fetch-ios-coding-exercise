//
//  Utilities.swift
//  Dessert Finder
//
//  Created by Usman Qazi on 6/21/24.
//

class Utilities {
    
    static let countryFlags: [String: String] = [
        "Afghanistani": "🇦🇫", "Albanian": "🇦🇱", "Algerian": "🇩🇿", "Andorran": "🇦🇩", "Angolan": "🇦🇴",
        "Antiguan": "🇦🇬", "Argentinian": "🇦🇷", "Armenian": "🇦🇲", "Australian": "🇦🇺", "Austrian": "🇦🇹",
        "Azerbaijani": "🇦🇿", "Bahamian": "🇧🇸", "Bahraini": "🇧🇭", "Bangladeshi": "🇧🇩", "Barbadian": "🇧🇧",
        "Belarusian": "🇧🇾", "Belgian": "🇧🇪", "Belizean": "🇧🇿", "Beninese": "🇧🇯", "Bermudian": "🇧🇲", "Bhutanese": "🇧🇹",
        "Bolivian": "🇧🇴", "Bosnian": "🇧🇦", "Motswana": "🇧🇼", "Brazilian": "🇧🇷", "Bruneian": "🇧🇳",
        "Bulgarian": "🇧🇬", "Burkinabe": "🇧🇫", "Burundian": "🇧🇮", "Cambodian": "🇰🇭", "Cameroonian": "🇨🇲",
        "Canadian": "🇨🇦", "Cape Verdean": "🇨🇻", "Central African": "🇨🇫", "Chadian": "🇹🇩", "Chilean": "🇨🇱",
        "Chinese": "🇨🇳", "Colombian": "🇨🇴", "Comorian": "🇰🇲", "Congolese": "🇨🇬", "Congolese (Democratic Rep)": "🇨🇩",
        "Costa Rican": "🇨🇷", "Croatian": "🇭🇷", "Cuban": "🇨🇺", "Cypriot": "🇨🇾", "Czech": "🇨🇿",
        "Danish": "🇩🇰", "Djiboutian": "🇩🇯", "Dominican": "🇩🇲", "Dominican Republic": "🇩🇴", "East Timorese": "🇹🇱",
        "Ecuadorian": "🇪🇨", "Egyptian": "🇪🇬", "Salvadoran": "🇸🇻", "Equatorial Guinean": "🇬🇶", "Eritrean": "🇪🇷",
        "Estonian": "🇪🇪", "Eswatini": "🇸🇿", "Ethiopian": "🇪🇹", "Fijian": "🇫🇯", "Finnish": "🇫🇮", "French": "🇫🇷",
        "Gabonese": "🇬🇦", "Gambian": "🇬🇲", "Georgian": "🇬🇪", "German": "🇩🇪", "Ghanaian": "🇬🇭", "Greek": "🇬🇷",
        "Grenadian": "🇬🇩", "Guatemalan": "🇬🇹", "Guinean": "🇬🇳", "Guinea-Bissauan": "🇬🇼", "Guyanese": "🇬🇾",
        "Haitian": "🇭🇹", "Honduran": "🇭🇳", "Hungarian": "🇭🇺", "Icelander": "🇮🇸", "Indian": "🇮🇳", "Indonesian": "🇮🇩",
        "Iranian": "🇮🇷", "Iraqi": "🇮🇶", "Irish": "🇮🇪", "Italian": "🇮🇹", "Ivorian": "🇨🇮",
        "Jamaican": "🇯🇲", "Japanese": "🇯🇵", "Jordanian": "🇯🇴", "Kazakhstani": "🇰🇿",
        "Kenyan": "🇰🇪", "I-Kiribati": "🇰🇮", "North Korean": "🇰🇵", "South Korean": "🇰🇷", "Kosovar": "🇽🇰",
        "Kuwaiti": "🇰🇼", "Kyrgyz": "🇰🇬", "Laotian": "🇱🇦", "Latvian": "🇱🇻", "Lebanese": "🇱🇧", "Basotho": "🇱🇸",
        "Liberian": "🇱🇷", "Libyan": "🇱🇾", "Liechtensteiner": "🇱🇮", "Lithuanian": "🇱🇹", "Luxembourger": "🇱🇺",
        "Malagasy": "🇲🇬", "Malawian": "🇲🇼", "Malaysian": "🇲🇾", "Maldivian": "🇲🇻", "Malian": "🇲🇱",
        "Maltese": "🇲🇹", "Marshallese": "🇲🇭", "Mauritanian": "🇲🇷", "Mauritian": "🇲🇺", "Mexican": "🇲🇽",
        "Micronesian": "🇫🇲", "Moldovan": "🇲🇩", "Monégasque": "🇲🇨", "Mongolian": "🇲🇳", "Montenegrin": "🇲🇪",
        "Moroccan": "🇲🇦", "Mozambican": "🇲🇿", "Burmese": "🇲🇲", "Namibian": "🇳🇦", "Nauruan": "🇳🇷",
        "Nepalese": "🇳🇵", "Dutch": "🇳🇱", "New Zealander": "🇳🇿", "Nicaraguan": "🇳🇮", "Nigerien": "🇳🇪",
        "Nigerian": "🇳🇬", "Norwegian": "🇳🇴", "Omani": "🇴🇲", "Pakistani": "🇵🇰", "Palauan": "🇵🇼", "Palestinian": "🇵🇸",
        "Panamanian": "🇵🇦", "Papua New Guinean": "🇵🇬", "Paraguayan": "🇵🇾", "Peruvian": "🇵🇪", "Filipino": "🇵🇭",
        "Polish": "🇵🇱", "Portuguese": "🇵🇹", "Qatari": "🇶🇦", "Romanian": "🇷🇴", "Russian": "🇷🇺",
        "Rwandan": "🇷🇼", "Saint Kittsian & Nevisian": "🇰🇳", "Saint Lucian": "🇱🇨", "Saint Vincentian & Grenadine": "🇻🇨",
        "Samoan": "🇼🇸", "San Marinese": "🇸🇲", "Sao Tomean": "🇸🇹", "Saudi": "🇸🇦", "Senegalese": "🇸🇳", "Serbian": "🇷🇸", "Seychellois": "🇸🇨",
        "Sierra Leonean": "🇸🇱", "Singaporean": "🇸🇬", "Slovak": "🇸🇰", "Slovene": "🇸🇮", "Solomon Islander": "🇸🇧",
        "Somali": "🇸🇴", "South African": "🇿🇦", "South Sudanese": "🇸🇸", "Spanish": "🇪🇸", "Sri Lankan": "🇱🇰",
        "Sudanese": "🇸🇩", "Surinamese": "🇸🇷", "Swedish": "🇸🇪", "Swiss": "🇨🇭", "Syrian": "🇸🇾", "Taiwanese": "🇹🇼",
        "Tajik": "🇹🇯", "Tanzanian": "🇹🇿", "Thai": "🇹🇭", "Togolese": "🇹🇬", "Tongan": "🇹🇴", "Trinidadian & Tobagonian": "🇹🇹",
        "Tunisian": "🇹🇳", "Turkish": "🇹🇷", "Turkmen": "🇹🇲", "Tuvaluan": "🇹🇻", "Ugandan": "🇺🇬", "Ukrainian": "🇺🇦",
        "Emirati": "🇦🇪", "British": "🇬🇧", "American": "🇺🇸", "Uruguayan": "🇺🇾", "Uzbek": "🇺🇿", "Vanuatuan": "🇻🇺",
        "Vatican": "🇻🇦", "Venezuelan": "🇻🇪", "Vietnamese": "🇻🇳", "Yemeni": "🇾🇪", "Zambian": "🇿🇲", "Zimbabwean": "🇿🇼"
    ]
    
}
