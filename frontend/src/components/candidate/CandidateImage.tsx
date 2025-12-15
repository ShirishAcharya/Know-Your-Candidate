// import Image from "next/image";
// import { UserCircleIcon } from "@heroicons/react/24/solid";

// interface CandidateImageProps {
//   imageFilename?: string | null;
//   name?: string;
//   size?: "sm" | "md" | "lg" | "xl";
//   className?: string;
// }

// const sizes = {
//   sm: "w-16 h-16",
//   md: "w-24 h-24",
//   lg: "w-32 h-32",
//   xl: "w-48 h-48",
// };

// export default function CandidateImage({
//   imageFilename,
//   name = "Candidate",
//   size = "lg",
//   className = "",
// }: CandidateImageProps) {
//   if (!imageFilename) {
//     return (
//       <div
//         className={`${sizes[size]} ${className} rounded-full bg-gradient-to-br from-gray-200 to-gray-300 flex items-center justify-center shadow-xl`}
//       >
//         <UserCircleIcon className="w-full h-full text-gray-500 p-4" />
//       </div>
//     );
//   }

//   return (
//     <Image
//       src={`/api/images/${imageFilename}`} // ← Uses your proxy
//       alt={name}
//       width={192}
//       height={192}
//       className={`${sizes[size]} ${className} rounded-full object-cover shadow-2xl`}
//       unoptimized
//       priority
//     />
//   );
// }