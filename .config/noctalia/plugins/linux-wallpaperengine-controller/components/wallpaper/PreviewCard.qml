import QtQuick
import QtQuick.Layouts
import QtMultimedia

import "../../helpers/panel/DescriptionHelpers.js" as DescriptionHelpers

import qs.Commons
import qs.Widgets

ColumnLayout {
  id: root

  property var pluginApi: null
  property var selectedWallpaperData: null
  property var propertyCompatibilityBadgeIconForPath: null
  property var propertyCompatibilityBadgeTextForPath: null
  property var propertyCompatibilityBadgeColorForPath: null
  property var propertyCompatibilityBadgeBackgroundForPath: null
  property var resolutionBadgeIcon: null
  property var resolutionBadgeLabel: null
  property var typeLabel: null
  property var typeBadgeIcon: null
  property var dynamicBadgeIcon: null
  property var badgeOrder: []
  property var isVideoMotion: null
  property var formatBytes: null
  property bool showDescription: true
  readonly property var visibleBadgeKeys: {
    const ordered = root.badgeOrder || [];
    const result = [];
    for (const key of ordered) {
      if (root.badgeVisible(String(key || ""))) {
        result.push(String(key || ""));
      }
    }
    return result;
  }
  property bool descriptionExpanded: false
  property bool descriptionShouldCollapse: false
  readonly property int collapsedDescriptionLineCount: 6
  readonly property real collapsedDescriptionHeight: descriptionFontMetrics.height * root.collapsedDescriptionLineCount
  readonly property string selectedDescriptionMarkup: {
    return DescriptionHelpers.toRichDescription(root.selectedWallpaperData?.description || "");
  }

  function evaluateDescriptionCollapse() {
    if (root.selectedDescriptionMarkup.length === 0) {
      root.descriptionShouldCollapse = false;
      return;
    }

    const measuredLinesRaw = Number(descriptionMeasureText.lineCount || 0);
    const measuredHeight = Number(descriptionMeasureText.contentHeight || 0);
    const lineHeight = Math.max(1, Number(descriptionFontMetrics.height || 1));
    const measuredLines = measuredLinesRaw > 0 ? measuredLinesRaw : Math.ceil(measuredHeight / lineHeight);
    const rawDescription = String(root.selectedWallpaperData?.description || "");
    const normalizedRaw = rawDescription
      .replace(/\r\n/g, "\n")
      .replace(/\r/g, "\n")
      .replace(/\\n/g, "\n");
    const hardBreakCount = normalizedRaw.split(/\n+/).length;
    const longTextHint = normalizedRaw.length > 900;

    if (measuredLinesRaw > 0 || measuredHeight > 0) {
      root.descriptionShouldCollapse = measuredLines > root.collapsedDescriptionLineCount;
      return;
    }

    root.descriptionShouldCollapse = hardBreakCount > root.collapsedDescriptionLineCount + 1 || longTextHint;
  }

  function badgeVisible(key) {
    if (!root.selectedWallpaperData) {
      return false;
    }
    if (key === "resolution") {
      return root.resolutionBadgeLabel && root.resolutionBadgeLabel(root.selectedWallpaperData.resolution).length > 0;
    }
    if (key === "type") {
      return root.typeLabel && root.typeLabel(root.selectedWallpaperData.type).length > 0;
    }
    if (key === "dynamic") {
      return true;
    }
    if (key === "music") {
      return !!root.selectedWallpaperData.hasEmbeddedAudio;
    }
    if (key === "reactive") {
      return !!root.selectedWallpaperData.hasAudioReactive;
    }
    if (key === "approved") {
      return !!root.selectedWallpaperData.approved;
    }
    if (key === "compatibility") {
      const path = String(root.selectedWallpaperData.path || "");
      return root.propertyCompatibilityBadgeTextForPath && root.propertyCompatibilityBadgeTextForPath(path).length > 0;
    }
    return false;
  }

  Layout.fillWidth: true
  spacing: Style.marginS

  onSelectedWallpaperDataChanged: {
    descriptionExpanded = false;
    descriptionCollapseEvalTimer.restart();
  }
  onSelectedDescriptionMarkupChanged: descriptionCollapseEvalTimer.restart()
  onWidthChanged: descriptionCollapseEvalTimer.restart()

  Rectangle {
    Layout.fillWidth: true
    Layout.preferredHeight: 180 * Style.uiScaleRatio
    radius: Style.radiusM
    color: Color.mSurfaceVariant
    clip: true

    Image {
      anchors.fill: parent
      visible: root.selectedWallpaperData && (!root.selectedWallpaperData.motionPreview || root.selectedWallpaperData.motionPreview.length === 0) && root.selectedWallpaperData.thumb && root.selectedWallpaperData.thumb.length > 0
      source: visible ? ("file://" + root.selectedWallpaperData.thumb) : ""
      fillMode: Image.PreserveAspectCrop
      cache: false
    }

    AnimatedImage {
      anchors.fill: parent
      visible: root.selectedWallpaperData && root.selectedWallpaperData.motionPreview && root.selectedWallpaperData.motionPreview.length > 0 && !(root.isVideoMotion && root.isVideoMotion(root.selectedWallpaperData.motionPreview))
      source: visible ? ("file://" + root.selectedWallpaperData.motionPreview) : ""
      fillMode: Image.PreserveAspectCrop
      cache: false
      playing: visible
    }

    Video {
      anchors.fill: parent
      visible: root.selectedWallpaperData && root.selectedWallpaperData.motionPreview && root.selectedWallpaperData.motionPreview.length > 0 && root.isVideoMotion && root.isVideoMotion(root.selectedWallpaperData.motionPreview)
      autoPlay: true
      loops: MediaPlayer.Infinite
      muted: true
      fillMode: VideoOutput.PreserveAspectCrop
      source: visible ? ("file://" + root.selectedWallpaperData.motionPreview) : ""
    }
  }

  NText {
    Layout.fillWidth: true
    text: root.selectedWallpaperData ? root.selectedWallpaperData.name : ""
    color: Color.mOnSurface
    font.weight: Font.Bold
    elide: Text.ElideRight
  }

  Item {
    Layout.fillWidth: true
    Layout.preferredHeight: badgeFlow.implicitHeight

    Flow {
      id: badgeFlow
      width: parent.width
      spacing: Style.marginS

      Repeater {
        model: root.visibleBadgeKeys

        Loader {
          required property var modelData
          sourceComponent: {
            const key = String(modelData || "");
            if (key === "resolution") return resolutionBadgeComponent;
            if (key === "type") return typeBadgeComponent;
            if (key === "dynamic") return motionBadgeComponent;
            if (key === "music") return musicBadgeComponent;
            if (key === "reactive") return reactiveBadgeComponent;
            if (key === "approved") return approvedBadgeComponent;
            if (key === "compatibility") return compatibilityBadgeComponent;
            return null;
          }
        }
      }

      Component {
        id: resolutionBadgeComponent

        Rectangle {
          color: Qt.alpha(Color.mSurfaceVariant, 0.24)
          radius: Style.radiusS
          width: resolutionBadgeContent.implicitWidth + Style.marginS * 2
          height: resolutionBadgeContent.implicitHeight + Style.marginXS * 2

          RowLayout {
            id: resolutionBadgeContent
            anchors.centerIn: parent
            spacing: Style.marginXS

            NIcon {
              icon: "aspect-ratio"
              pointSize: Style.fontSizeM
              color: Color.mOnSurfaceVariant
            }

            NText {
              text: root.resolutionBadgeLabel ? root.resolutionBadgeLabel(root.selectedWallpaperData.resolution) : ""
              color: Color.mOnSurfaceVariant
              font.pointSize: Style.fontSizeXS
              font.weight: Font.Medium
              elide: Text.ElideRight
            }
          }
        }
      }

      Component {
        id: typeBadgeComponent

        Rectangle {
          color: Qt.alpha(Color.mSecondary, 0.1)
          radius: Style.radiusS
          width: typeBadgeContent.implicitWidth + Style.marginS * 2
          height: typeBadgeContent.implicitHeight + Style.marginXS * 2

          RowLayout {
            id: typeBadgeContent
            anchors.centerIn: parent
            spacing: Style.marginXS

            NIcon {
              icon: root.typeBadgeIcon ? root.typeBadgeIcon(root.selectedWallpaperData.type) : "category"
              pointSize: Style.fontSizeM
              color: Color.mSecondary
            }

            NText {
              text: root.typeLabel ? root.typeLabel(root.selectedWallpaperData.type) : ""
              color: Color.mSecondary
              font.pointSize: Style.fontSizeXS
              font.weight: Font.Medium
              elide: Text.ElideRight
            }
          }
        }
      }

      Component {
        id: motionBadgeComponent

        Rectangle {
          color: root.selectedWallpaperData.dynamic
            ? Qt.alpha(Color.mTertiary, 0.1)
            : Qt.alpha(Color.mOutline, 0.1)
          radius: Style.radiusS
          width: motionBadgeContent.implicitWidth + Style.marginS * 2
          height: motionBadgeContent.implicitHeight + Style.marginXS * 2

          RowLayout {
            id: motionBadgeContent
            anchors.centerIn: parent
            spacing: Style.marginXS

            NIcon {
              icon: root.dynamicBadgeIcon
                ? root.dynamicBadgeIcon(!!root.selectedWallpaperData.dynamic)
                : (root.selectedWallpaperData.dynamic ? "player-play" : "player-stop")
              pointSize: Style.fontSizeM
              color: root.selectedWallpaperData.dynamic ? Color.mTertiary : Color.mOnSurfaceVariant
            }

            NText {
              text: root.selectedWallpaperData.dynamic
                ? pluginApi?.tr("panel.dynamicBadge")
                : pluginApi?.tr("panel.staticBadge")
              color: root.selectedWallpaperData.dynamic ? Color.mTertiary : Color.mOnSurfaceVariant
              font.pointSize: Style.fontSizeXS
              font.weight: Font.Medium
              elide: Text.ElideRight
            }
          }
        }
      }

      Component {
        id: musicBadgeComponent

        Rectangle {
          color: Qt.alpha(Color.mPrimary, 0.1)
          radius: Style.radiusS
          width: audioBadgeContent.implicitWidth + Style.marginS * 2
          height: audioBadgeContent.implicitHeight + Style.marginXS * 2

          RowLayout {
            id: audioBadgeContent
            anchors.centerIn: parent
            spacing: Style.marginXS

            NIcon {
              icon: "volume"
              pointSize: Style.fontSizeM
              color: Color.mPrimary
            }

            NText {
              text: pluginApi?.tr("panel.musicBadge")
              color: Color.mPrimary
              font.pointSize: Style.fontSizeXS
              font.weight: Font.Medium
              elide: Text.ElideRight
            }
          }
        }
      }

      Component {
        id: reactiveBadgeComponent

        Rectangle {
          color: Qt.alpha(Color.mSecondary, 0.1)
          radius: Style.radiusS
          width: reactiveBadgeContent.implicitWidth + Style.marginS * 2
          height: reactiveBadgeContent.implicitHeight + Style.marginXS * 2

          RowLayout {
            id: reactiveBadgeContent
            anchors.centerIn: parent
            spacing: Style.marginXS

            NIcon {
              icon: "wave-sine"
              pointSize: Style.fontSizeM
              color: Color.mSecondary
            }

            NText {
              text: pluginApi?.tr("panel.reactiveBadge")
              color: Color.mSecondary
              font.pointSize: Style.fontSizeXS
              font.weight: Font.Medium
              elide: Text.ElideRight
            }
          }
        }
      }

      Component {
        id: approvedBadgeComponent

        Rectangle {
          color: Qt.alpha(Color.mPrimary, 0.1)
          radius: Style.radiusS
          width: approvedBadgeContent.implicitWidth + Style.marginS * 2
          height: approvedBadgeContent.implicitHeight + Style.marginXS * 2

          RowLayout {
            id: approvedBadgeContent
            anchors.centerIn: parent
            spacing: Style.marginXS

            NIcon {
              icon: "rosette-discount-check"
              pointSize: Style.fontSizeM
              color: Color.mPrimary
            }

            NText {
              text: pluginApi?.tr("panel.approvedBadge")
              color: Color.mPrimary
              font.pointSize: Style.fontSizeXS
              font.weight: Font.Medium
              elide: Text.ElideRight
            }
          }
        }
      }

      Component {
        id: compatibilityBadgeComponent

        Rectangle {
          id: compatibilityBadge
          readonly property string compatibilityPath: String(root.selectedWallpaperData?.path || "")
          readonly property string compatibilityLabel: root.propertyCompatibilityBadgeTextForPath ? root.propertyCompatibilityBadgeTextForPath(compatibilityPath) : ""
          readonly property color compatibilityColor: root.propertyCompatibilityBadgeColorForPath ? root.propertyCompatibilityBadgeColorForPath(compatibilityPath) : Color.mError
          readonly property string compatibilityIcon: root.propertyCompatibilityBadgeIconForPath ? root.propertyCompatibilityBadgeIconForPath(compatibilityPath) : "alert-triangle"
          color: root.propertyCompatibilityBadgeBackgroundForPath
            ? root.propertyCompatibilityBadgeBackgroundForPath(compatibilityPath)
            : Qt.alpha(compatibilityColor, 0.1)
          radius: Style.radiusS
          width: compatBadgeContent.implicitWidth + Style.marginS * 2
          height: compatBadgeContent.implicitHeight + Style.marginXS * 2

          RowLayout {
            id: compatBadgeContent
            anchors.centerIn: parent
            spacing: Style.marginXS

            NIcon {
              icon: "settings-cog"
              pointSize: Style.fontSizeM
              color: compatibilityBadge.compatibilityColor
            }

            NText {
              text: compatibilityBadge.compatibilityLabel
              color: compatibilityBadge.compatibilityColor
              font.pointSize: Style.fontSizeXS
              font.weight: Font.Medium
              elide: Text.ElideRight
            }
          }
        }
      }
    }
  }

  RowLayout {
    Layout.fillWidth: true
    Layout.topMargin: Style.marginM

    NText {
      text: pluginApi?.tr("panel.infoType")
      color: Color.mOnSurfaceVariant
    }

    Item { Layout.fillWidth: true }

    NText {
      text: root.selectedWallpaperData && root.typeLabel ? root.typeLabel(root.selectedWallpaperData.type) : ""
      color: Color.mOnSurface
    }
  }

  RowLayout {
    Layout.fillWidth: true

    NText {
      text: pluginApi?.tr("panel.infoId")
      color: Color.mOnSurfaceVariant
    }

    Item { Layout.fillWidth: true }

    NText {
      text: root.selectedWallpaperData ? root.selectedWallpaperData.id : ""
      color: Color.mOnSurface
      elide: Text.ElideMiddle
    }
  }

  RowLayout {
    Layout.fillWidth: true

    NText {
      text: pluginApi?.tr("panel.infoResolution")
      color: Color.mOnSurfaceVariant
    }

    Item { Layout.fillWidth: true }

    NText {
      text: root.selectedWallpaperData
        ? (String(root.selectedWallpaperData.resolution || "unknown") === "unknown"
          ? pluginApi?.tr("panel.resolutionUnknown")
          : root.selectedWallpaperData.resolution)
        : ""
      color: Color.mOnSurface
    }
  }

  RowLayout {
    Layout.fillWidth: true

    NText {
      text: pluginApi?.tr("panel.infoSize")
      color: Color.mOnSurfaceVariant
    }

    Item { Layout.fillWidth: true }

    NText {
      text: root.selectedWallpaperData && root.formatBytes ? root.formatBytes(root.selectedWallpaperData.bytes) : ""
      color: Color.mOnSurface
    }
  }

  ColumnLayout {
    Layout.fillWidth: true
    visible: root.showDescription && root.selectedDescriptionMarkup.length > 0
    spacing: Style.marginXS

    FontMetrics {
      id: descriptionFontMetrics
      font: descriptionText.font
    }

    NText {
      Layout.fillWidth: true
      text: pluginApi?.tr("panel.infoDescription")
      color: Color.mOnSurfaceVariant
    }

    Rectangle {
      Layout.fillWidth: true
      implicitHeight: {
        if (!root.descriptionShouldCollapse || root.descriptionExpanded) {
          return descriptionText.implicitHeight + Style.marginS * 2;
        }
        return root.collapsedDescriptionHeight + Style.marginS * 2;
      }
      radius: Style.radiusM
      color: Qt.alpha(Color.mSurfaceVariant, 0.2)
      border.width: Style.borderS
      border.color: Qt.alpha(Color.mOutline, 0.22)
      clip: true

      NText {
        id: descriptionMeasureText
        visible: false
        width: descriptionText.width
        text: root.selectedDescriptionMarkup
        textFormat: Text.RichText
        wrapMode: Text.Wrap
        font: descriptionText.font
        onContentHeightChanged: descriptionCollapseEvalTimer.restart()
      }

      NText {
        id: descriptionText
        anchors.fill: parent
        anchors.margins: Style.marginS
        text: root.selectedDescriptionMarkup
        textFormat: Text.RichText
        color: Color.mOnSurfaceVariant
        wrapMode: Text.Wrap
        linkColor: Color.mPrimary
        onLinkActivated: url => Qt.openUrlExternally(url)
      }

      Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 36 * Style.uiScaleRatio
        visible: root.descriptionShouldCollapse && !root.descriptionExpanded
        color: Qt.rgba(
          Color.mSurfaceVariant.r,
          Color.mSurfaceVariant.g,
          Color.mSurfaceVariant.b,
          0.28
        )
      }
    }

    NButton {
      Layout.fillWidth: true
      visible: root.descriptionShouldCollapse || root.descriptionExpanded
      text: root.descriptionExpanded ? pluginApi?.tr("panel.showLess") : pluginApi?.tr("panel.showMore")
      icon: root.descriptionExpanded ? "chevron-up" : "chevron-down"
      onClicked: root.descriptionExpanded = !root.descriptionExpanded
    }
  }

  Timer {
    id: descriptionCollapseEvalTimer
    interval: 40
    repeat: false
    onTriggered: root.evaluateDescriptionCollapse()
  }
}
