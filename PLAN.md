# Flutter App Plan for YouTube Clone ("Streamly")

## Information Gathered from Backend

- Backend is Node.js with Express and Mongoose.
- API base path: `/api/v1`
- User API: registration, login, logout, refresh token, profile update, avatar/cover upload, watch history, channel profile.
- Video API: publish, update, delete, get all videos with pagination and search, toggle publish status.
- Playlist API: create, update, delete, add/remove videos, get user playlists.
- Subscription API: subscribe/unsubscribe channels, get subscribers and subscribed channels.
- Like API: like/unlike videos and comments, get liked videos.
- Comment API: add, update, delete, get comments for videos.
- Authentication uses JWT tokens with refresh tokens in cookies.
- Media uploads handled via Cloudinary.

## Flutter Project Structure

- `lib/`
  - `main.dart`: app entry point, routing setup.
  - `globals/`
    - `globals.dart`: contains `baseUrl` variable for backend API.
    - `global_constants.dart`: app-wide constants.
    - `themes.dart`: app theme data.
  - `models/`: Dart data models for User, Video, Playlist, Subscription, Like, Comment.
  - `services/`: API service classes for each backend resource (UserService, VideoService, etc.) handling HTTP requests.
  - `providers/`: State management providers (using Provider or Riverpod).
  - `screens/`
    - `authentication/`: login, registration screens.
    - `home_screen.dart`: main video feed with search and pagination.
    - `video_detail_screen.dart`: video player, comments, likes.
    - `profile_screen.dart`: user profile, watch history, playlists.
    - `playlist_screen.dart`: playlist management.
    - `subscription_screen.dart`: subscribed channels.
  - `widgets/`: reusable UI components (video cards, comment widgets, buttons).
  - `utils/`: helper functions (e.g., for date formatting, snackbar).
  - `functions/`: e.g., snackbar helper.

## API Service Layer

- Use `http` package for REST API calls.
- Base URL stored in `globals.dart` as `baseUrl`.
- Handle authentication tokens (accessToken, refreshToken) securely.
- Intercept 401 responses to refresh tokens automatically.
- Support file uploads (avatar, cover image, video, thumbnail) using multipart requests.

## Authentication Handling

- Login and registration screens with form validation.
- Store JWT tokens securely (e.g., using flutter_secure_storage).
- Use Provider/Riverpod to manage auth state.
- Protect routes that require authentication.
- Support logout and token refresh.

## UI/UX Design Approach

- Modern, minimalistic design with clean layouts.
- Use Material Design components.
- Responsive layouts for different screen sizes.
- Smooth navigation and transitions.
- Video player integration (e.g., using `video_player` package).
- Use app icons and assets from `assets/` folder.

## Integration of Backend Features

- User: registration, login, profile update, avatar/cover upload, watch history.
- Video: video feed with pagination and search, video upload, update, delete, toggle publish.
- Playlist: create, update, delete playlists, add/remove videos.
- Subscription: subscribe/unsubscribe channels, view subscribed channels.
- Like: like/unlike videos and comments, view liked videos.
- Comment: add, update, delete, view comments on videos.

## Media Upload Handling

- Use multipart HTTP requests for uploading images and videos.
- Show upload progress indicators.
- Validate file types and sizes before upload.

## State Management Approach

- Use Provider or Riverpod for state management.
- Separate UI and business logic.
- Use ChangeNotifier or StateNotifier for reactive UI updates.

## Followup Steps

- Implement the Flutter app according to this plan.
- Test API integration thoroughly.
- Test authentication flows and token refresh.
- Test media uploads.
- Test UI responsiveness and usability.
- Prepare for deployment and backend URL configuration via `baseUrl`.

---

Please confirm if you want me to proceed with the implementation of this Flutter app based on this plan.
