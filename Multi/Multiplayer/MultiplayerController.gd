extends Node

var PORT = 12212
var IP_ADDRESS = "localhost"
var MAX_CLIENTS = 4

@onready
var label : RichTextLabel = $RichTextLabel
@onready
var nickTextBox : LineEdit = $NickTextBox
@onready
var lineTextBox : LineEdit = $LineTextBox

@onready
var ipPopup : Window = $IpPopup
@onready
var ipPopupText : RichTextLabel = $IpPopup/Label

var request: HTTPRequest

func _init():
	print_debug("init")
	request = HTTPRequest.new()

# check ip

func _on_check_ip_button_pressed():
	print_debug("click")
	showMyIp()

func showMyIp():
	ipPopup.show()
	ipPopupText.text = "fetching..."
	add_child(request)
	request.request_completed.connect(self.onRequestCompleted)
	request.request("https://api.ipify.org")

func onRequestCompleted(_result, _response_code, _headers, body):
	var addresses = IP.get_local_addresses()
	ipPopupText.text = " ==== IPs:\n"
	ipPopupText.text += " * External\n"
	ipPopupText.text += "- " + body.get_string_from_utf8() + "\n"
	ipPopupText.text += " * Internal\n"
	for a in addresses:
		ipPopupText.text += "- " + a + "\n"

func _on_ip_popup_close_requested():
	ipPopup.hide()

# server

func onServerClicked():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT, MAX_CLIENTS)
	multiplayer.multiplayer_peer = peer
	label.text = "server opened on port "+str(PORT)
	$ServerButton.disabled = true
	$ClientButton.visible = false

# client

func onClientClicked():
	$ConnectPopup.show()

func _on_connect_popup_close_requested():
	$ConnectPopup.hide()

func _on_connect_button_pressed():
	$ConnectPopup.hide()
	var server_ip_address = $ConnectPopup/VBoxContainer/ServerLineEdit.text
	var server_port = int($ConnectPopup/VBoxContainer/PortLineEdit.text)
	label.text = "connecting to " + str(server_ip_address) + " : "+str(server_port)
	var peer = ENetMultiplayerPeer.new()
	var connResult = peer.create_client(server_ip_address, server_port)
	multiplayer.multiplayer_peer = peer
	label.text += "\nconnected (" + str(connResult) + ")"
	$ClientButton.disabled = true
	$ServerButton.visible = false

#rpcs

func onSayHelloClicked():
	chatMessageRpc.rpc( nickTextBox.text, lineTextBox.text)
	lineTextBox.clear()

@rpc("any_peer", "call_local", "reliable")
func chatMessageRpc(nick: String, text: String):
	label.text += "\n"+"[" + nick +"]"+text +\
		"\n... from id /"+str(multiplayer.get_remote_sender_id())

