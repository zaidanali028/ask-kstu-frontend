const buildUrl = 'http://192.168.137.170:8000/api/v1';

const loginUrl = buildUrl + '/login';
const registerUrl = buildUrl + '/register';
const logoutUrl = buildUrl + '/logout';
const userUrl = buildUrl + '/me';

const noticeUrl = buildUrl + '/announcements/notice-board';
const announcementUrl = buildUrl + '/announcements/trending-news';
const announcementDetailUrl = buildUrl + '/announcement';
const likesUrl = buildUrl + '/post-interact/announcements';

const serverError = "Server Error";
const unauthorized = "Unauthorized";
const somethingWentwrong = "Something went wrong, try again";