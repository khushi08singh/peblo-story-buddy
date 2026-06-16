# Peblo Story Buddy

## Overview

This project is a Flutter implementation of the **Peblo AI Story Buddy & Quiz Component Challenge**.

The app provides a child-friendly storytelling experience where a virtual Story Buddy narrates a short story using Text-to-Speech (TTS) and then reveals a data-driven quiz once narration is complete.

The implementation focuses on:

* Kid-friendly UI/UX
* Smooth state transitions
* Data-driven quiz rendering
* Lightweight performance for mid-range Android devices
* Error handling and user feedback

---

## Framework Choice

### Flutter

I chose Flutter because:

* Single codebase for multiple platforms
* Excellent UI customization capabilities
* Strong widget ecosystem
* Easy integration with Text-to-Speech packages
* Fast iteration and development speed

---

## Architecture

Project structure:

```text
lib/
├── models/
│   └── quiz_model.dart
├── providers/
│   └── story_provider.dart
├── screens/
│   └── home_screen.dart
├── services/
│   └── tts_service.dart
├── utils/
│   └── constants.dart
├── widgets/
│   ├── buddy_character.dart
│   ├── story_card.dart
│   └── quiz_card.dart
└── main.dart
```

### Responsibilities

* **Model** → Quiz data structure
* **Provider** → State management and business logic
* **Service** → TTS integration
* **Widgets** → Reusable UI components
* **Screen** → Layout composition

---

## State Management

Provider was used to manage:

* Loading state
* Audio playback state
* Quiz visibility
* Success state
* Error state
* Feedback messages

This keeps UI and business logic separated and easy to maintain.

---

## Audio → Quiz Transition

When the user taps **Read Me a Story**:

1. Loading state begins
2. Flutter TTS is initialized
3. Story narration starts
4. Quiz remains hidden during narration
5. TTS completion callback is triggered
6. Quiz is revealed automatically

Implementation uses the TTS completion handler to ensure the quiz appears only after narration finishes.

---

## Data-Driven Quiz Rendering

The quiz is generated from JSON data rather than hardcoded UI.

Example:

```json
{
  "question": "What colour was Pip the Robot's lost gear?",
  "options": ["Red", "Green", "Blue", "Yellow"],
  "answer": "Blue"
}
```

Options are rendered dynamically using:

```dart
quiz.options.map(...)
```

This means the renderer can handle:

* 3 options
* 4 options
* 5 options
* Different question text

without any code changes.

---

## User Interaction

### Wrong Answer

* Haptic feedback
* Shake animation
* Retry allowed

### Correct Answer

* Confetti celebration
* Happy Buddy state
* Success message

This creates a playful and rewarding experience for children.

---

## Audio Loading & Failure Handling

### Loading

A loading state is shown while TTS is being prepared.

### Failure Handling

If narration fails:

* A friendly error message is displayed
* The app remains responsive
* The user can retry

This prevents crashes or blocked UI states.

---

## Caching Approach

The implementation uses the device's native Text-to-Speech engine via `flutter_tts`.

Since no remote audio files are downloaded, caching is not required.

If remote audio APIs (such as ElevenLabs) were used, audio files would be cached locally using temporary storage to avoid repeated downloads and reduce network usage.

---

## Performance Profiling

### Focus Areas

* Smooth quiz reveal
* Smooth shake animation
* Smooth confetti animation
* Lightweight rendering

### What Was Measured

* Frame rendering smoothness during animations
* General responsiveness while narration and quiz transitions occur

### Optimizations Applied

* Provider used to minimize unnecessary rebuilds
* Reusable widgets extracted from the main screen
* Native TTS used instead of streaming audio
* Single-screen architecture
* Lightweight asset usage
* No heavy background processing

### Target Device

The app was designed with Peblo's target audience in mind:

* Mid-range Android devices
* Approximately 3GB RAM

Animations remained responsive and visually smooth during testing.

---

## AI Usage & Judgment

AI tools were used for:

* Debugging Flutter issues
* Reviewing state-management approaches
* UI brainstorming
* Code review and refinement

### Suggestion Rejected

An AI-generated suggestion recommended adding more complex visual effects and additional animations throughout the screen.

I chose not to implement those changes because they would increase UI complexity and could negatively affect performance on lower-end Android devices.

### Issue Encountered

One issue encountered was ensuring that the quiz appeared only after narration completed.

Initial implementations caused timing inconsistencies.

This was resolved by using the Text-to-Speech completion callback and updating Provider state only after narration finished.

---

## Packages Used

```yaml
provider
flutter_tts
confetti
```

---

## Features Implemented

* Kid-friendly UI
* Story Buddy character
* Text-to-Speech narration
* Loading state
* Error handling
* Data-driven quiz rendering
* Quiz reveal after narration
* Haptic feedback
* Shake animation
* Confetti celebration
* Success state
* Provider-based state management

---

## Screen Recording

The recording demonstrates:

1. Story narration
2. Quiz reveal after narration
3. Wrong answer feedback
4. Correct answer celebration
5. Success state

---

## Author

Submitted as part of the Peblo Flutter Developer Intern Challenge.

