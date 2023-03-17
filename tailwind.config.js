/** @type {import('tailwindcss').Config} */
module.exports = {
    content: ['./**/*.{html,js}'],
    theme: {
        screens: {
            sm: '480px',
            md: '768px',
            lg: '976px',
            xl: '1440px',
        },
        extend: {
            colors: {
                primaryColor  : '#1887B0',
                secondaryColor: '#D2EAF6',
                primaryDark   : '#161921',
                secondaryDark : '#4D5267',
                background    : '#EDF3F6',
            },
        },
    },
    plugins: [],
}
