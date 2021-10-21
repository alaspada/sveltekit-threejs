<script lang=ts>
	import { onMount } from 'svelte';

	//import { websocketStore } from "svelte-websocket-store";
	import type { websocketStore } from './svelte-websocket-store';

	import * as THREE from 'three';
	import {OrbitControls} from 'three/examples/jsm/controls/OrbitControls.js';

	class Game {
		private scene: THREE.Scene;
		private camera: THREE.PerspectiveCamera;
		private renderer: THREE.WebGLRenderer;
		private directionalLight: THREE.DirectionalLight;
        private ambientLight: THREE.AmbientLight;
        private cubeGeometry: THREE.BoxBufferGeometry
        private cubeMaterial: THREE.MeshStandardMaterial
        private floorGeometry: THREE.PlaneBufferGeometry
        private floorMaterial: THREE.MeshStandardMaterial
        private cube: THREE.Mesh;
        private floor: THREE.Mesh;
        private controls: OrbitControls


		public constructor() {
			this.scene = new THREE.Scene();
			this.scene.background = new THREE.Color(0xedf2f7);

			this.camera = new THREE.PerspectiveCamera(
				75,
				window.innerWidth / window.innerHeight,
				0.1,
				1000
			);
			this.camera.position.x = 0;
			this.camera.position.y = 0;
            this.camera.position.z = 3;
            this.camera.lookAt(this.scene.position);

			this.directionalLight = new THREE.DirectionalLight( 0xffffff, 0.8 );
			this.directionalLight.position.set(1, 2, 1);
			this.directionalLight.castShadow = true;
			this.directionalLight.shadow.bias = - 0.0005;
			this.scene.add(this.directionalLight);

            this.ambientLight = new THREE.AmbientLight(0x707070, 1.25);
            this.scene.add(this.ambientLight);

			this.cubeGeometry = new THREE.BoxBufferGeometry(1, 1, 1);
			this.cubeMaterial = new THREE.MeshStandardMaterial({
				color: new THREE.Color(0xff3e00),
				metalness: 0.5,
				roughness: 0.5,
				side: THREE.DoubleSide
			})          
			this.cube = new THREE.Mesh(this.cubeGeometry, this.cubeMaterial);
            this.cube.castShadow = true;
            this.cube.receiveShadow = true;
            this.cube.position.set(0,0,0);
			this.scene.add(this.cube);

			this.floorGeometry = new THREE.PlaneBufferGeometry(4, 4, 4, 4);
			this.floorMaterial = new THREE.MeshStandardMaterial({
				color: new THREE.Color(0xf7fafc),
				roughness: 0.5,
				metalness: 0.5,
				side: THREE.DoubleSide
			});
            this.floor = new THREE.Mesh(this.floorGeometry, this.floorMaterial);
            this.floor.receiveShadow = true;            
            this.floor.position.set(0, -0.501, 0);
            this.floor.rotateX( Math.PI / 2  )
			this.scene.add(this.floor);

			this.renderer = new THREE.WebGLRenderer({
				antialias: true, 
				alpha: true
			});
			this.renderer.setSize(window.innerWidth, window.innerHeight);
			this.renderer.shadowMap.enabled = true;
			this.renderer.shadowMap.type = THREE.PCFSoftShadowMap;
            document.body.appendChild(this.renderer.domElement);

            this.controls = new OrbitControls( this.camera, this.renderer.domElement );
            this.controls.enableDamping = true;
            this.controls.autoRotate = true;
            this.animate();
		}

		public animate(): void {
            let game = this;
			requestAnimationFrame(function () {
				game.animate();
			});
			this.controls.update();
			this.renderer.render(this.scene, this.camera);
		}
	}

	onMount(async () => {
		let game = new Game();
        game.animate()
	});

</script>
