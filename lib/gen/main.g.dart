import "package:nyxx_commands/src/context/chat_context.dart"
    as package_nyxx_commands__src__context__chat_context___dart;
import "dart:core" as dart_core;
import "package:nyxx/src/models/message/attachment.dart"
    as package_nyxx__src__models__message__attachment___dart;
import "package:shit_ui_app/bot_shit/utils/dartcord/converter.dart"
    as package_shit_ui_app__bot_shit__utils__dartcord__converter___dart;
import 'package:nyxx_commands/src/mirror_utils/mirror_utils.dart';
import 'package:shit_ui_app/main.dart' as _main show main;
import "dart:core";

// Auto-generated file
// DO NOT EDIT

// Function data

const Map<dynamic, FunctionData> functionData = {
  'buttondemo': FunctionData([
    ParameterData(
      name: "context",
      type: const RuntimeType<
          package_nyxx_commands__src__context__chat_context___dart
          .ChatContext>.allowingDynamic(),
      isOptional: false,
      description: null,
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
    ParameterData(
      name: "selection",
      type: const RuntimeType<dart_core.String?>.allowingDynamic(),
      isOptional: true,
      description: "Numeral for buttons to showcase",
      defaultValue: null,
      choices: const {
        '1 Button': 'ONE',
        '2 Buttons': 'TWO',
        '3 Buttons': 'THREE',
      },
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
  ]),
  'selectionmenudemo': FunctionData([
    ParameterData(
      name: "context",
      type: const RuntimeType<
          package_nyxx_commands__src__context__chat_context___dart
          .ChatContext>.allowingDynamic(),
      isOptional: false,
      description: null,
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
  ]),
  'embed_embed': FunctionData([
    ParameterData(
      name: "context",
      type: const RuntimeType<
          package_nyxx_commands__src__context__chat_context___dart
          .ChatContext>.allowingDynamic(),
      isOptional: false,
      description: null,
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
    ParameterData(
      name: "title",
      type: const RuntimeType<dart_core.String?>.allowingDynamic(),
      isOptional: true,
      description: "This is where I put descriptions",
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
    ParameterData(
      name: "timestamp",
      type: const RuntimeType<dart_core.bool?>.allowingDynamic(),
      isOptional: true,
      description: "Timestamp?",
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
    ParameterData(
      name: "footer",
      type: const RuntimeType<dart_core.String?>.allowingDynamic(),
      isOptional: true,
      description: "This is another one!",
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
  ]),
  'cat_embed': FunctionData([
    ParameterData(
      name: "context",
      type: const RuntimeType<
          package_nyxx_commands__src__context__chat_context___dart
          .ChatContext>.allowingDynamic(),
      isOptional: false,
      description: null,
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
  ]),
  'ai_image': FunctionData([
    ParameterData(
      name: "context",
      type: const RuntimeType<
          package_nyxx_commands__src__context__chat_context___dart
          .ChatContext>.allowingDynamic(),
      isOptional: false,
      description: null,
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
    ParameterData(
      name: "prompt",
      type: const RuntimeType<dart_core.String?>.allowingDynamic(),
      isOptional: true,
      description: "Get an image from the prompt that you say here!",
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
  ]),
  'ai_image_edit': FunctionData([
    ParameterData(
      name: "context",
      type: const RuntimeType<
          package_nyxx_commands__src__context__chat_context___dart
          .ChatContext>.allowingDynamic(),
      isOptional: false,
      description: null,
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
    ParameterData(
      name: "attachment",
      type: const RuntimeType<
          package_nyxx__src__models__message__attachment___dart
          .Attachment?>.allowingDynamic(),
      isOptional: true,
      description:
          "4MB Image upload [PNG, JPG, JPEG, and WEBP] (THE IMAGE YOU WANT EDITED)",
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
    ParameterData(
      name: "maskFormat",
      type: const RuntimeType<dart_core.String?>.allowingDynamic(),
      isOptional: true,
      description: "This is the Mask for the image (Masked = Changed)",
      defaultValue: null,
      choices: const {
        'MaskBottom': "BOTTOM_MASK",
        'MaskTop': "TOP_MASK",
        'MaskLeft': "LEFT_MASK",
        'MaskRight': "RIGHT_MASK",
        'MaskInner': "INNER_MASK",
        'MaskOuter': "OUTER_MASK",
        'EmptyMask (No change)': "EMPTY_MASK",
        'FullMask (Full Change)': "FULL_MASK",
      },
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
    ParameterData(
      name: "prompt",
      type: const RuntimeType<dart_core.String?>.allowingDynamic(),
      isOptional: true,
      description: "This is the prompt for the AI to use",
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
  ]),
  'ai_image_vary': FunctionData([
    ParameterData(
      name: "context",
      type: const RuntimeType<
          package_nyxx_commands__src__context__chat_context___dart
          .ChatContext>.allowingDynamic(),
      isOptional: false,
      description: null,
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
    ParameterData(
      name: "attachment",
      type: const RuntimeType<
          package_nyxx__src__models__message__attachment___dart
          .Attachment?>.allowingDynamic(),
      isOptional: true,
      description: "4MB Image upload [PNG, JPG, JPEG, and WEBP]",
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
  ]),
  'pingchoices': FunctionData([
    ParameterData(
      name: "context",
      type: const RuntimeType<
          package_nyxx_commands__src__context__chat_context___dart
          .ChatContext>.allowingDynamic(),
      isOptional: false,
      description: null,
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
    ParameterData(
      name: "selection",
      type: const RuntimeType<dart_core.String?>.allowingDynamic(),
      isOptional: true,
      description: "The type of latency to view",
      defaultValue: null,
      choices: const {
        'Basic latency': 'Basic',
        'Real latency': 'Real',
        'Gateway latency': 'Gateway',
      },
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
  ]),
  'pingselection': FunctionData([
    ParameterData(
      name: "context",
      type: const RuntimeType<
          package_nyxx_commands__src__context__chat_context___dart
          .ChatContext>.allowingDynamic(),
      isOptional: false,
      description: null,
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
  ]),
  'pingstring': FunctionData([
    ParameterData(
      name: "context",
      type: const RuntimeType<
          package_nyxx_commands__src__context__chat_context___dart
          .ChatContext>.allowingDynamic(),
      isOptional: false,
      description: null,
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
    ParameterData(
      name: "selection",
      type: const RuntimeType<dart_core.String?>.allowingDynamic(),
      isOptional: true,
      description: "The type of latency to view",
      defaultValue: null,
      choices: null,
      converterOverride:
          package_shit_ui_app__bot_shit__utils__dartcord__converter___dart
              .latencyTypeConverter,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
  ]),
  'build-hub': FunctionData([
    ParameterData(
      name: "context",
      type: const RuntimeType<
          package_nyxx_commands__src__context__chat_context___dart
          .ChatContext>.allowingDynamic(),
      isOptional: false,
      description: null,
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
  ]),
  'create': FunctionData([
    ParameterData(
      name: "context",
      type: const RuntimeType<
          package_nyxx_commands__src__context__chat_context___dart
          .ChatContext>.allowingDynamic(),
      isOptional: false,
      description: null,
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
  ]),
  'users': FunctionData([
    ParameterData(
      name: "context",
      type: const RuntimeType<
          package_nyxx_commands__src__context__chat_context___dart
          .ChatContext>.allowingDynamic(),
      isOptional: false,
      description: null,
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
    ParameterData(
      name: "function",
      type: const RuntimeType<dart_core.String?>.allowingDynamic(),
      isOptional: true,
      description: "Add or Remove a user from a ticket.",
      defaultValue: null,
      choices: const {
        'Add': "Add",
        'Remove': "Remove",
      },
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
    ParameterData(
      name: "userId",
      type: const RuntimeType<dart_core.String?>.allowingDynamic(),
      isOptional: true,
      description: "The user to add or remove. (Right-click Copy ID)",
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
  ]),
  'close': FunctionData([
    ParameterData(
      name: "context",
      type: const RuntimeType<
          package_nyxx_commands__src__context__chat_context___dart
          .ChatContext>.allowingDynamic(),
      isOptional: false,
      description: null,
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
  ]),
  'history': FunctionData([
    ParameterData(
      name: "context",
      type: const RuntimeType<
          package_nyxx_commands__src__context__chat_context___dart
          .ChatContext>.allowingDynamic(),
      isOptional: false,
      description: null,
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
    ParameterData(
      name: "ticketId",
      type: const RuntimeType<dart_core.String?>.allowingDynamic(),
      isOptional: true,
      description:
          "The Ticket number you want to view the history of (The 00000 number)",
      defaultValue: null,
      choices: null,
      converterOverride: null,
      autocompleteOverride: null,
      localizedDescriptions: null,
      localizedNames: null,
    ),
  ]),
};
// Main function wrapper
void main(List<String> args) {
  loadData(functionData);
}
