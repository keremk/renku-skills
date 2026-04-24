# Timeline And Transcription Reference

Use this only when the user wants a composition/timeline output, rendered video, subtitles, or karaoke-style transcription. Do not add these pieces to asset-only blueprints unless requested.

## Timeline Composer

The timeline composer assembles media tracks into a timeline artifact for export or preview.

Blueprint import:

```yaml
imports:
  - name: TimelineComposer
    producer: composition/timeline-composer
```

It usually runs once and receives looped media through fan-in inputs.

Model config belongs in `inputs.yaml` or the input template:

```yaml
models:
  - model: timeline/ordered
    provider: renku
    producerId: TimelineComposer
    config:
      timeline:
        tracks: ["Video", "Audio"]
        masterTracks: ["Audio"]
        videoClip:
          artifact: VideoSegments
        audioClip:
          artifact: AudioSegments
```

## Track Design

Only include tracks that correspond to media the blueprint actually produces.

Common track roles:

- `Video`: generated video clips.
- `Image`: still images/Ken Burns-style segments.
- `Audio`: narration, dialogue, or speech tracks.
- `Music`: background music.
- `Transcription`: audio timing for subtitles.

`masterTracks` controls timing. For narration-led documentaries, audio often drives timing. For video-led ads or music videos, video may drive timing.

## Fan-In To Timeline

Wire looped artifacts into timeline fan-in inputs:

```yaml
- from: VideoProducer[segment].GeneratedVideo
  to: TimelineComposer.VideoSegments

- from: NarrationAudioProducer[segment].GeneratedAudio
  to: TimelineComposer.AudioSegments
```

For two-dimensional still images:

```yaml
- from: SegmentImageProducer[segment][image].GeneratedImage
  to: TimelineComposer.ImageSegments
```

The timeline producer contract determines the exact fan-in input names and dimensions. Inspect it before wiring.

Always wire duration if the composer requires it:

```yaml
- from: Duration
  to: TimelineComposer.Duration
```

## Exporter

Add a video exporter only for rendered final video endpoints:

```yaml
imports:
  - name: VideoExporter
    producer: composition/video-exporter

connections:
  - from: TimelineComposer.Timeline
    to: VideoExporter.Timeline
  - from: VideoExporter.FinalVideo
    to: FinalVideo
```

Exporter model/config belongs in `models:`.

## Transcription/Karaoke

Add transcription only when the user wants subtitles or speech alignment.

Typical chain:

```text
Audio or video AudioTrack -> TimelineComposer.TranscriptionAudio
TimelineComposer.Timeline -> TranscriptionProducer.Timeline
TranscriptionProducer.Transcription -> VideoExporter.Transcription
```

For talking-head/lipsync workflows, prefer the generated video's derived `AudioTrack` for transcription:

```yaml
- from: TalkingHeadVideoProducer[segment].AudioTrack
  to: TimelineComposer.TranscriptionAudio
```

This aligns subtitles to the actual video output rather than to an upstream narration file that may differ in duration.

## Gotchas

- Do not add `Transcription` track without wiring transcription audio.
- Do not route original TTS audio as a separate audible track when it is only intended to drive lipsync.
- Do not add music by default.
- Do not add timeline/exporter to asset-only pipelines.
- Keep timeline `artifact` config names aligned with the timeline producer's fan-in input names.
