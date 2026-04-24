# Prompt Guidance Sites

This file is the source map and guide index for the per-model prompt references used by `renku-write-prompts`.

Last refreshed: 2026-04-24

## How to use this file

- Prefer official vendor prompt guides first.
- If the vendor does not publish a real prompt guide, use official model docs plus one or two strong secondary guides.
- Treat community or X threads as supporting material, not the main source, unless official guidance is missing.
- Use the concrete guide files in `../renku-write-prompts/references/` first when they exist. Use this file when you need to trace or refresh the underlying sources.

## Available guide files

### Image models

- `nano-banana.md`
- `seedream-5-lite.md`
- `flux-2-pro-max.md`
- `flux-2-klein.md`
- `grok-imagine-image.md`
- `qwen-image-2512.md`

### Video models

- `seedance-1-5.md`
- `veo-3-1.md`
- `grok-imagine-video.md`
- `kling-3.md`
- `ltx-2-3.md`
- `wan-2-7.md`

## Image Models

| Model | Provider | Official / primary sources | Supplemental sources | Why these matter |
|-------|----------|----------------------------|----------------------|------------------|
| Nano Banana 2 | Google | [Ultimate prompting guide for Nano Banana](https://cloud.google.com/blog/products/ai-machine-learning/ultimate-prompting-guide-for-nano-banana)<br>[Gemini 3.1 Flash Image docs](https://docs.cloud.google.com/vertex-ai/generative-ai/docs/models/gemini/3-1-flash-image) | [Build with Nano Banana 2](https://blog.google/technology/developers/build-with-nano-banana-2/) | Best official prompt guidance in this set. Covers prompt formulas, editing workflows, text rendering, localization, references, and web-grounded image generation. |
| Nano Banana Pro | Google | [Ultimate prompting guide for Nano Banana](https://cloud.google.com/blog/products/ai-machine-learning/ultimate-prompting-guide-for-nano-banana)<br>[Gemini 3 Pro Image docs](https://docs.cloud.google.com/vertex-ai/generative-ai/docs/models/gemini/3-pro-image) | [Announcing Nano Banana Pro for every builder and business](https://cloud.google.com/blog/products/ai-machine-learning/nano-banana-pro-available-for-enterprise) | Shares the same main prompt guide as Nano Banana 2, but the product docs are still useful for model-specific limits, formats, and enterprise positioning. |
| Seedream 5.0 Lite | ByteDance Seed | [Seedream 5.0 Lite launch post](https://seed.bytedance.com/en/blog/deeper-thinking-more-accurate-generation-introducing-seedream-5-0-lite)<br>[Seedream 5.0 Lite product page](https://seed.bytedance.com/seedream5_0_lite) | [fal: Seedream 5.0 Lite prompting guide](https://blog.fal.ai/seedream-5-0-lite-prompting-guide/)<br>[fal model page](https://fal.ai/seedream-5.0) | ByteDance explains capabilities well, but fal currently has the most explicit prompt tactics and example structures. |
| FLUX.2 Pro / Max | Black Forest Labs | [FLUX.2 prompting guide](https://docs.bfl.ai/guides/prompting_guide_flux2)<br>[FLUX.2 overview](https://docs.bfl.ai/flux_2) | [FLUX.2 text-to-image](https://docs.bfl.ai/flux_2/flux2_text_to_image)<br>[FLUX.2 image editing](https://docs.bfl.ai/flux_2/flux2_image_editing) | Official BFL guide is the anchor. It is one of the clearest vendor-authored prompt guides for image generation structure and instruction style. |
| FLUX.2 Klein | Black Forest Labs | [FLUX.2 Klein prompting guide](https://docs.bfl.ai/guides/prompting_guide_flux2_klein)<br>[FLUX.2 Klein training docs](https://docs.bfl.ai/flux_2/flux2_klein_training) | [FLUX.2 overview](https://docs.bfl.ai/flux_2) | Separate from the main FLUX.2 guide and worth its own row because Klein has different strengths, especially around editable and trainable workflows. |
| Grok Imagine Image | xAI | [xAI image generation docs](https://docs.x.ai/developers/model-capabilities/images/generation) | [How to prompt Grok Imagine](https://www.genaintel.com/guides/how-to-prompt-grok-imagine) | I did not find a deep official prompt guide yet. The official docs are good for workflows and parameters, while the third-party guide is a useful candidate for prompt patterns and tested examples. |
| Qwen-Image-2512 | Qwen | [Qwen-Image GitHub repo](https://github.com/QwenLM/Qwen-Image)<br>[Qwen-Image-2512 model card](https://huggingface.co/Qwen/Qwen-Image-2512) | [fal: Qwen-Image-2512 prompt guide](https://fal.ai/learn/devs/qwen-image-2512-text-to-image-prompt-guide) | Official sources show recommended prompt enhancers, example prompts, aspect ratios, and generation settings. fal adds practical prompt-writing guidance for deployed use. |

## Video Models

| Model | Provider | Official / primary sources | Supplemental sources | Why these matter |
|-------|----------|----------------------------|----------------------|------------------|
| Seedance 1.5 Pro | ByteDance Seed | [Seedance 1.5 Pro product page](https://seed.bytedance.com/en/seedance1_5_pro)<br>[Seedance 1.5 Pro technical report](https://seed.bytedance.com/public_papers/seedance-1-5-pro-a-native-audio-visual-joint-generation-foundation-model) | [fal: Seedance 1.5 prompt guide](https://fal.ai/learn/devs/seedance-1-5-prompt-guide)<br>[fal: Seedance 1.5 user guide](https://fal.ai/learn/devs/seedance-1-5-user-guide) | ByteDance explains the model and strengths, but fal currently appears to have the clearest prompt-engineering guidance for production use. |
| Seedance 2.0 | ByteDance Seed | [Seedance 2.0 model page](https://seed.bytedance.com/en/seedance2_0)<br>[Seedance 2.0 official launch post](https://seed.bytedance.com/en/blog/official-launch-of-seedance-2-0) | [fal: How to use Seedance 2.0](https://fal.ai/learn/tools/how-to-use-seedance-2-0) | ByteDance explains the multimodal workflow and capability jump, while fal currently has the clearest practical guidance for shot structure, references, audio, and multi-shot prompting. |
| Veo 3.1 | Google | [Ultimate prompting guide for Veo 3.1](https://cloud.google.com/blog/products/ai-machine-learning/ultimate-prompting-guide-for-veo-3-1)<br>[Veo on Vertex AI docs](https://docs.cloud.google.com/vertex-ai/generative-ai/docs/models/veo/3-1-generate-preview) | [LTX Studio: Veo prompt guide](https://ltx.studio/blog/veo-prompt-guide) | The Google guide is the main source. It is unusually strong because it covers shot design, camera language, audio prompting, and structured prompt formulas. |
| Grok Imagine Video | xAI | [xAI video generation docs](https://docs.x.ai/developers/model-capabilities/video/generation)<br>[Grok Imagine Video model docs](https://docs.x.ai/developers/models/grok-imagine-video) | [How to prompt Grok Imagine](https://www.genaintel.com/guides/how-to-prompt-grok-imagine) | Same pattern as the image model: official docs explain features and request structure, but not yet a rich official prompt guide. |
| Kling VIDEO 3.0 | Kling AI / Kuaishou | [Kling VIDEO 3.0 model user guide](https://app.klingai.com/cn/quickstart/klingai-video-3-model-user-guide) | [fal: Kling 3.0 prompting guide](https://blog.fal.ai/kling-3-0-prompting-guide/)<br>[Kling style emulation guide](https://kling.ai/blog/kling-ai-video-style-emulation-guide) | Official guide is strong on feature behavior, multi-shot, subject binding, and voice control. fal adds more direct prompt-writing advice. |
| LTX-2.3 | Lightricks / LTX Studio | [LTX-2.3 prompt guide](https://ltx.io/model/model-blog/ltx-2-3-prompt-guide)<br>[How to generate 20-second AI videos with LTX-2.3](https://ltx.io/model/model-blog/how-to-generate-20-second-ai-videos)<br>[LTX audio-to-video API reference](https://docs.ltx.video/api-documentation/api-reference/video-generation/audio-to-video) | [LTX-2.3 model page](https://ltx.io/model/ltx-2-3)<br>[fal LTX-2.3 audio-to-video schema](https://fal.ai/models/fal-ai/ltx-2.3/audio-to-video/api) | Official LTX material is strong and practical, especially on camera movement, subject action, prompt specificity, and duration-aware prompting. The audio-to-video docs/schema ground talking-head guidance in the exposed audio plus single-image workflow. |
| Wan 2.7 | Alibaba | [Alibaba Cloud text-to-video / image-to-video prompt guide](https://www.alibabacloud.com/help/en/model-studio/text-to-video-prompt)<br>[Wan general video editing guide](https://www.alibabacloud.com/help/en/model-studio/wan-vace-guide) | [Wan 2.7 prompt guide](https://wan27ai.com/prompt-guide)<br>[WaveSpeed model page](https://wavespeed.ai/models/alibaba/wan-2.7/video-edit) | Alibaba has a real official prompt guide, which is more important than the third-party sites. The official docs are especially useful because they break prompting into formulas for T2V, I2V, sound, reference video, and multi-shot work. |

## Gaps and caveats

- Grok Imagine Image and Grok Imagine Video: I found official docs and API guidance, but not a first-party prompt guide on the level of Google, Black Forest Labs, or Alibaba.
- Seedance 1.5 Pro: the best explicit prompt-writing advice currently looks to be on fal rather than ByteDance.
- Seedream 5.0 Lite: the official material is strong for capability framing, but fal appears better for direct prompt patterns and examples.
- FLUX.2 naming is moving quickly across variants. When we create the per-model guides, we should double-check which exact variants `renku-write-prompts` should support and name the files accordingly.

## Notes on coverage

- `nano-banana.md` covers both Nano Banana 2 and Nano Banana Pro because Google's primary prompting guidance is shared across that family.
- The Grok guides are intentionally marked lower confidence because xAI's official prompt-guidance layer is still thinner than the strongest vendors in this set.
