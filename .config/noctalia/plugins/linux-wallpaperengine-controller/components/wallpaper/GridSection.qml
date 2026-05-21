import QtQuick
import QtQuick.Layouts
import QtMultimedia

import "../shared"

import qs.Commons
import qs.Widgets

ColumnLayout {
  id: root

  property var pluginApi: null
  property var mainInstance: null
  property var wallpapers: []
  property string pendingPath: ""
  property string selectedPath: ""
  property bool scanningWallpapers: false
  property int wallpaperItemsCount: 0
  property int visibleWallpaperCount: 0
  property int currentPage: 0
  property int pageCount: 1
  property int currentPageDisplay: 0
  property int currentPageStartIndex: 0
  property int currentPageEndIndex: 0
  property bool paginationVisible: false
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

  function showBadge(key, modelData) {
    const order = root.badgeOrder || [];
    if (order.indexOf(key) < 0) {
      return false;
    }

    if (key === "type") {
      return root.typeLabel && root.typeLabel(modelData.type).length > 0;
    }
    if (key === "dynamic") {
      return true;
    }
    if (key === "music") {
      return !!modelData.hasEmbeddedAudio;
    }
    if (key === "reactive") {
      return !!modelData.hasAudioReactive;
    }
    if (key === "approved") {
      return !!modelData.approved;
    }
    if (key === "resolution") {
      return root.resolutionBadgeIcon && root.resolutionBadgeIcon(modelData.resolution).length > 0;
    }
    if (key === "compatibility") {
      return root.propertyCompatibilityBadgeTextForPath
        && root.propertyCompatibilityBadgeTextForPath(String(modelData.path || "")).length > 0;
    }

    return false;
  }

  signal wallpaperActivated(string path)
  signal previousPageRequested()
  signal nextPageRequested()

  Layout.fillWidth: true
  Layout.fillHeight: true
  spacing: Style.marginS

  Component {
    id: wallpaperCardDelegate

Rectangle {
        id: tileCard
        required property var modelData
        readonly property var wallpaperData: modelData
       readonly property bool isPending: root.pendingPath === modelData.path
       readonly property bool isSelected: root.selectedPath === modelData.path
       readonly property bool isMotion: modelData.motionPreview && modelData.motionPreview.length > 0
       readonly property bool isVideoMotion: root.isVideoMotion && root.isVideoMotion(modelData.motionPreview)
       width: GridView.view.cellWidth
       height: GridView.view.cellHeight
       radius: Style.radiusL
       color: Qt.alpha(Color.mSurface, 0.82)
       border.width: isPending ? 2 : (isSelected ? 1 : 0)
       border.color: isPending ? Color.mPrimary : Qt.alpha(Color.mOutline, 0.45)
       clip: true

      ColumnLayout {
        anchors.fill: parent
        anchors.margins: Style.marginS
        spacing: Style.marginXS

        Rectangle {
          Layout.fillWidth: true
          Layout.preferredHeight: 136 * Style.uiScaleRatio
          radius: Style.radiusM
          color: Color.mSurfaceVariant
          clip: true

          Image {
            anchors.fill: parent
            visible: modelData.thumb && modelData.thumb.length > 0
            source: visible ? ("file://" + modelData.thumb) : ""
            fillMode: Image.PreserveAspectCrop
            cache: false
          }

          Loader {
            anchors.fill: parent
            active: tileCard.isMotion
            sourceComponent: tileCard.isVideoMotion ? motionVideoComponent : motionAnimatedComponent
          }

          Component {
            id: motionAnimatedComponent

            AnimatedImage {
              anchors.fill: parent
              source: "file://" + modelData.motionPreview
              fillMode: Image.PreserveAspectCrop
              cache: false
              playing: true
            }
          }

          Component {
            id: motionVideoComponent

            Video {
              anchors.fill: parent
              autoPlay: true
              loops: MediaPlayer.Infinite
              muted: true
              fillMode: VideoOutput.PreserveAspectCrop
              source: "file://" + modelData.motionPreview
            }
          }

          NIcon {
            anchors.centerIn: parent
            visible: (!modelData.thumb || modelData.thumb.length === 0) && (!modelData.motionPreview || modelData.motionPreview.length === 0)
            icon: "photo"
            pointSize: Style.fontSizeXL
            color: Color.mOnSurfaceVariant
          }
        }

        RowLayout {
          Layout.fillWidth: true
          spacing: Style.marginXS

          NText {
            Layout.fillWidth: true
            text: modelData.name
            color: Color.mOnSurface
            elide: Text.ElideRight
            font.weight: Font.Medium
          }

          NIcon {
            visible: root.selectedPath === modelData.path
            icon: "check"
            pointSize: Style.fontSizeL
            color: Color.mPrimary
          }
        }

        Item {
          id: badgeContainer
          Layout.fillWidth: true
          Layout.preferredHeight: badgeFlow.implicitHeight
          readonly property var visibleBadgeKeys: {
            const ordered = root.badgeOrder || [];
            const result = [];
            for (const key of ordered) {
              if (root.showBadge(String(key || ""), modelData)) {
                result.push(String(key || ""));
              }
            }
            return result;
          }

          Flow {
            id: badgeFlow
            width: parent.width
            spacing: Style.marginXS

            Repeater {
              model: badgeContainer.visibleBadgeKeys

              Loader {
                required property var modelData
                sourceComponent: {
                  const key = String(modelData || "");
                  if (key === "type") return typeBadgeComponent;
                  if (key === "dynamic") return dynamicBadgeComponent;
                  if (key === "music") return musicBadgeComponent;
                  if (key === "reactive") return reactiveBadgeComponent;
                  if (key === "approved") return approvedBadgeComponent;
                  if (key === "resolution") return resolutionBadgeComponent;
                  if (key === "compatibility") return compatibilityBadgeComponent;
                  return null;
                }
              }
            }
          }

          Component {
            id: typeBadgeComponent

            Rectangle {
              color: Qt.alpha(Color.mSecondary, 0.18)
              radius: Style.radiusXS
              implicitWidth: typeBadgeRow.implicitWidth + Style.marginS * 2
              implicitHeight: typeBadgeText.implicitHeight + Style.marginXS * 2

              RowLayout {
                id: typeBadgeRow
                anchors.centerIn: parent
                spacing: Style.marginXS

                NIcon {
                  icon: root.typeBadgeIcon ? root.typeBadgeIcon(tileCard.wallpaperData.type) : "category"
                  pointSize: Style.fontSizeM
                  color: Color.mSecondary
                }

                NText {
                  id: typeBadgeText
                  text: root.typeLabel ? root.typeLabel(tileCard.wallpaperData.type) : ""
                  color: Color.mSecondary
                  font.pointSize: Style.fontSizeXS
                  font.weight: Font.Medium
                }
              }
            }
          }

          Component {
            id: dynamicBadgeComponent

            Rectangle {
              color: Qt.alpha(Color.mTertiary, 0.18)
              radius: Style.radiusXS
              implicitWidth: motionBadgeIcon.implicitWidth + Style.marginXS * 2
              implicitHeight: motionBadgeIcon.implicitHeight + Style.marginXS * 2

              NIcon {
                id: motionBadgeIcon
                anchors.centerIn: parent
                icon: root.dynamicBadgeIcon ? root.dynamicBadgeIcon(!!tileCard.wallpaperData.dynamic) : (tileCard.wallpaperData.dynamic ? "player-play" : "player-stop")
                pointSize: Style.fontSizeM
                color: tileCard.wallpaperData.dynamic ? Color.mTertiary : Color.mOnSurfaceVariant
              }
            }
          }

          Component {
            id: musicBadgeComponent

            Rectangle {
              color: Qt.alpha(Color.mPrimary, 0.16)
              radius: Style.radiusXS
              implicitWidth: musicBadgeIcon.implicitWidth + Style.marginXS * 2
              implicitHeight: musicBadgeIcon.implicitHeight + Style.marginXS * 2

              NIcon {
                id: musicBadgeIcon
                anchors.centerIn: parent
                icon: "volume"
                pointSize: Style.fontSizeM
                color: Color.mPrimary
              }
            }
          }

          Component {
            id: reactiveBadgeComponent

            Rectangle {
              color: Qt.alpha(Color.mSecondary, 0.16)
              radius: Style.radiusXS
              implicitWidth: reactiveBadgeIcon.implicitWidth + Style.marginXS * 2
              implicitHeight: reactiveBadgeIcon.implicitHeight + Style.marginXS * 2

              NIcon {
                id: reactiveBadgeIcon
                anchors.centerIn: parent
                icon: "wave-sine"
                pointSize: Style.fontSizeM
                color: Color.mSecondary
              }
            }
          }

          Component {
            id: approvedBadgeComponent

            Rectangle {
              color: Qt.alpha(Color.mPrimary, 0.16)
              radius: Style.radiusXS
              implicitWidth: approvedBadgeIcon.implicitWidth + Style.marginXS * 2
              implicitHeight: approvedBadgeIcon.implicitHeight + Style.marginXS * 2

              NIcon {
                id: approvedBadgeIcon
                anchors.centerIn: parent
                icon: "rosette-discount-check"
                pointSize: Style.fontSizeM
                color: Color.mPrimary
              }
            }
          }

          Component {
            id: resolutionBadgeComponent

            Rectangle {
              color: Qt.alpha(Color.mSurfaceVariant, 0.24)
              radius: Style.radiusXS
              implicitWidth: resolutionBadgeRow.implicitWidth + Style.marginS * 2
              implicitHeight: resolutionBadgeRow.implicitHeight + Style.marginXS * 2

              RowLayout {
                id: resolutionBadgeRow
                anchors.centerIn: parent
                spacing: Style.marginXS

                NIcon {
                  icon: "aspect-ratio"
                  pointSize: Style.fontSizeM
                  color: Color.mOnSurfaceVariant
                }

                NText {
                  text: root.resolutionBadgeLabel ? root.resolutionBadgeLabel(tileCard.wallpaperData.resolution) : ""
                  color: Color.mOnSurfaceVariant
                  font.pointSize: Style.fontSizeXS
                  font.weight: Font.Medium
                }
              }
            }
          }

          Component {
            id: compatibilityBadgeComponent

            Rectangle {
              readonly property string compatibilityPath: String(tileCard.wallpaperData.path || "")
              readonly property color compatibilityColor: root.propertyCompatibilityBadgeColorForPath ? root.propertyCompatibilityBadgeColorForPath(compatibilityPath) : Color.mError
              color: root.propertyCompatibilityBadgeBackgroundForPath
                ? root.propertyCompatibilityBadgeBackgroundForPath(compatibilityPath)
                : Qt.alpha(compatibilityColor, 0.16)
              radius: Style.radiusXS
              implicitWidth: compatibilityBadgeIcon.implicitWidth + Style.marginXS * 2
              implicitHeight: compatibilityBadgeIcon.implicitHeight + Style.marginXS * 2

              NIcon {
                id: compatibilityBadgeIcon
                anchors.centerIn: parent
                icon: "settings-cog"
                pointSize: Style.fontSizeM
                color: parent.compatibilityColor
              }
            }
          }
        }
      }

       MouseArea {
         anchors.fill: parent
         enabled: root.mainInstance?.engineAvailable ?? false
         hoverEnabled: true
         onClicked: root.wallpaperActivated(modelData.path)
       }
    }
  }

  CardGridSection {
    Layout.fillWidth: true
    Layout.fillHeight: true
    pluginApi: root.pluginApi
    items: root.wallpapers
    cardDelegate: wallpaperCardDelegate
    cellHeight: 208 * Style.uiScaleRatio
    showEmptyState: root.wallpapers.length === 0 && !root.scanningWallpapers
    emptyIcon: "photo"
    emptyText: root.wallpaperItemsCount === 0
      ? pluginApi?.tr("panel.emptyAll")
      : pluginApi?.tr("panel.emptyFiltered")
    paginationVisible: root.paginationVisible
    currentPage: root.currentPage
    pageCount: root.pageCount
    currentPageDisplay: root.currentPageDisplay
    currentPageStartIndex: root.currentPageStartIndex
    currentPageEndIndex: root.currentPageEndIndex
    totalVisibleCount: root.visibleWallpaperCount
    onPreviousPageRequested: root.previousPageRequested()
    onNextPageRequested: root.nextPageRequested()
  }
}
